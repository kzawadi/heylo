import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:zawadi/domain/auth/auth_failure.dart';
import 'package:zawadi/domain/auth/i_auth_facade.dart';
import 'package:zawadi/domain/auth/value_objects.dart';

@injectable
class SignInWithEmailAndPasswordUseCase {
  SignInWithEmailAndPasswordUseCase(this._authFacade);

  final IAuthFacade _authFacade;

  Future<Either<AuthFailure, Unit>> call({
    required EmailAddress emailAddress,
    required Password password,
  }) {
    return _authFacade.signInWithEmailAndPassword(
      emailAddress: emailAddress,
      password: password,
    );
  }
}
