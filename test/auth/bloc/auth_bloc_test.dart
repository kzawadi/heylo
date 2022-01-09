import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:zawadi/application/auth/auth_bloc.dart';
import 'package:zawadi/domain/auth/auth_failure.dart';
import 'package:zawadi/domain/auth/i_auth_facade.dart';
import 'package:zawadi/domain/auth/use_cases/auth_use_cases.dart';
import 'package:zawadi/domain/auth/user.dart';
import 'package:zawadi/domain/core/i_auth_use_cases.dart';
import 'package:zawadi/domain/core/value_objects.dart';

class MockIAuthFacade extends Mock implements IAuthFacade {}

// class MockAuthBloc extends Mock implements AuthBloc {}

class MockGetSignedInUserUseCase extends Mock
    implements GetSignedInUserUseCase {}

class MockSignOutUseCase extends Mock implements SignOutUseCase {}

void main() {
  late SignOutUseCase _signOutUseCase;
  late GetSignedInUserUseCase _getSignedInUserUseCase;

  setUpAll(
    () {
      _getSignedInUserUseCase = MockGetSignedInUserUseCase();
      _signOutUseCase = MockSignOutUseCase();
      // authBloc = ();
    },
  );

  group(
    'AuthBlocTest -',
    () {
      test('initial state is correct', () {
        final authBloc = AuthBloc(_getSignedInUserUseCase, _signOutUseCase);
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
          when(() => _getSignedInUserUseCase.call())
              .thenAnswer((_) => Future.value(some(User(id: UniqueId()))));
        },
        build: () => AuthBloc(_getSignedInUserUseCase, _signOutUseCase),
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
          when(() => _getSignedInUserUseCase.call())
              .thenAnswer((_) => Future.value(optionOf(null)));
        },
        build: () => AuthBloc(_getSignedInUserUseCase, _signOutUseCase),
        act: (bloc) => bloc.add(const AuthEvent.authCheckRequested()),
        expect: () => <AuthState>[const AuthState.unauthenticated()],
      );
    },
  );

  group(
    'emits AuthState.Unauthenticated when successful signed out',
    () {
      blocTest<AuthBloc, AuthState>(
        'emits AuthState.unauthenticated',
        setUp: () {
          when(() => _signOutUseCase.call(NoParams()))
              .thenAnswer((_) => Future.value(right(unit)));
        },
        build: () => AuthBloc(_getSignedInUserUseCase, _signOutUseCase),
        act: (bloc) => bloc.add(const AuthEvent.signedOut()),
        expect: () => <AuthState>[const AuthState.unauthenticated()],
      );
    },
  );
  group(
    'emits AuthState.authenticated when fail to signed out',
    () {
      blocTest<AuthBloc, AuthState>(
        'emits AuthState.unauthenticated',
        setUp: () {
          when(() => _signOutUseCase.call(NoParams())).thenAnswer(
            (_) => Future.value(left(const AuthFailure.serverError())),
          );
        },
        build: () => AuthBloc(_getSignedInUserUseCase, _signOutUseCase),
        act: (bloc) => bloc.add(const AuthEvent.signedOut()),
        expect: () => <AuthState>[const AuthState.unAuthenticatingFailure()],
      );
    },
  );
}
