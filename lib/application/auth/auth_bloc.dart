import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:zawadi/domain/auth/use_cases/auth_use_cases.dart';
import 'package:zawadi/domain/auth/user.dart';
import 'package:zawadi/domain/core/i_auth_use_cases.dart';

part 'auth_event.dart';
part 'auth_state.dart';

part 'auth_bloc.freezed.dart';

///This bloc handle all event and state of the apps user authentication journey
@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(
    this._getSignedInUserUseCase,
    this._signOutUseCase,
  ) : super(const AuthState.initial()) {
    on<AuthEvent>(_authEventshandler, transformer: sequential());
  }

  final GetSignedInUserUseCase _getSignedInUserUseCase;
  final SignOutUseCase _signOutUseCase;

  /// The handler functions which holds the application logic of authenticating
  /// the [User].
  FutureOr<void> _authEventshandler(
    AuthEvent event,
    Emitter<AuthState> emit,
  ) async {
    await event.map(
      authCheckRequested: (e) async {
        final userOption = await _getSignedInUserUseCase();
        emit(
          userOption.fold(
            () => const AuthState.unauthenticated(),
            (_) => const AuthState.authenticated(),
          ),
        );
      },
      signedOut: (e) => _signOutUseCase.call(NoParams()),
    );
  }
}
