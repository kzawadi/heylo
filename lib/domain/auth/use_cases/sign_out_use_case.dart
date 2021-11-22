import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:zawadi/domain/auth/auth_failure.dart';
import 'package:zawadi/domain/auth/i_auth_facade.dart';
import 'package:zawadi/domain/core/i_auth_use_cases.dart';

@injectable
class SignOutUseCase extends IUseCase<Unit, NoParams> {
  SignOutUseCase(this._authFacade);

  final IAuthFacade _authFacade;

  @override
  Future<Either<AuthFailure, Unit>> call(NoParams params) =>
      _authFacade.signOut();
}
