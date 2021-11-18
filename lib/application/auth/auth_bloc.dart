import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:zawadi/domain/auth/i_auth_facade.dart';
import 'package:zawadi/domain/auth/user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

part 'auth_bloc.freezed.dart';

///This bloc handle all event and state of the apps user authentication journey
@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this._authFacade) : super(const AuthState.initial()) {
    on<AuthEvent>(_authEventshandler, transformer: sequential());
  }

  final IAuthFacade _authFacade;

  /// The handler functions which holds the application logic of authenticating
  /// the [User].
  FutureOr<void> _authEventshandler(
    AuthEvent event,
    Emitter<AuthState> emit,
  ) async {
    await event.map(
      authCheckRequested: (e) async {
        final userOption = await _authFacade.getSignedInUser();
        emit(
          userOption.fold(
            () => const AuthState.unauthenticated(),
            (_) => const AuthState.authenticated(),
          ),
        );
      },
      signedOut: (e) async {
        await _authFacade.signOut();
      },
    );
  }
}
