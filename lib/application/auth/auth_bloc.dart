import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:zawadi/domain/auth/i_auth_facade.dart';

part 'auth_event.dart';
part 'auth_state.dart';

part 'auth_bloc.freezed.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this._authFacade) : super(const AuthState.initial()) {
    on<AuthCheckRequested>(_authCheckRequested);
    on<SignedOut>(_signOut);
  }

  final IAuthFacade _authFacade;

  Future _authCheckRequested(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    final userOption = await _authFacade.getSignedInUser();
    emit(
      userOption.fold(
        () => const AuthState.unauthenticated(),
        (_) => const AuthState.authenticated(),
      ),
    );
  }

  Future _signOut(
    SignedOut event,
    Emitter<AuthState> emit,
  ) async {
    await _authFacade.signOut();

    emit(const AuthState.unauthenticated());
  }
}
// class AuthBloc extends Bloc<AuthEvent, AuthState> {
//   AuthBloc(this._authFacade) : super(const AuthState.initial());
//   final IAuthFacade _authFacade;

//   @override
//   Stream<AuthState> mapEventToState(
//     AuthEvent event,
//   ) async* {
//     yield* event.map(
//       authCheckRequested: (e) async* {
//         final userOption = await _authFacade.getSignedInUser();
//         yield userOption.fold(
//           () => const AuthState.unauthenticated(),
//           (_) => const AuthState.authenticated(),
//         );
//       },
//       signedOut: (e) async* {
//         await _authFacade.signOut();
//         yield const AuthState.unauthenticated();
//       },
//     );
//   }
// }
