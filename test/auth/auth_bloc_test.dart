import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:zawadi/application/auth/auth_bloc.dart';
import 'package:zawadi/domain/auth/i_auth_facade.dart';
import 'package:zawadi/domain/auth/use_cases/auth_use_cases.dart';
import 'package:zawadi/domain/auth/user.dart';
import 'package:zawadi/domain/core/value_objects.dart';

class MockIAuthFacade extends Mock implements IAuthFacade {}

// class MockAuthBloc extends Mock implements AuthBloc {}

class MockGetSignedInUserUseCase extends Mock
    implements GetSignedInUserUseCase {}

class MockSignOutUseCase extends Mock implements SignOutUseCase {}

void main() {
  late SignOutUseCase signOutUseCase;
  late GetSignedInUserUseCase getSignedInUserUseCase;

  setUpAll(
    () {
      getSignedInUserUseCase = MockGetSignedInUserUseCase();
      signOutUseCase = MockSignOutUseCase();
      // authBloc = ();
    },
  );

  group(
    'AuthBlocTest -',
    () {
      test('initial state is correct', () {
        final authBloc = AuthBloc(getSignedInUserUseCase, signOutUseCase);
        expect(authBloc.state, const AuthState.initial());
      });
    },
  );

  group(
    'AuthBloc Logic tests',
    () {
      blocTest<AuthBloc, AuthState>(
        'emits AuthBloc.authenticated when a user is sign in',
        setUp: () {
          when(() => getSignedInUserUseCase.call())
              .thenAnswer((_) => Future.value(some(User(id: UniqueId()))));
        },
        build: () => AuthBloc(getSignedInUserUseCase, signOutUseCase),
        act: (bloc) => bloc.add(const AuthEvent.authCheckRequested()),
        expect: () => <AuthState>[const AuthState.authenticated()],
      );
    },
  );

  group(
    'emits AuthState.unauthnticated when getSignInUserCase return failure',
    () {
      blocTest<AuthBloc, AuthState>(
        'emits AuthBloc.unauthenticated when a user fail to sign-in',
        setUp: () {
          when(() => getSignedInUserUseCase.call())
              .thenAnswer((_) => Future.value(optionOf(null)));
        },
        build: () => AuthBloc(getSignedInUserUseCase, signOutUseCase),
        act: (bloc) => bloc.add(const AuthEvent.authCheckRequested()),
        expect: () => <AuthState>[const AuthState.unauthenticated()],
      );
    },
  );
}
