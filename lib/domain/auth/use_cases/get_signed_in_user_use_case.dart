import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:zawadi/domain/auth/i_auth_facade.dart';
import 'package:zawadi/domain/auth/user.dart';

@injectable
class GetSignedInUserUseCase {
  const GetSignedInUserUseCase(this._iAuthFacade);

  final IAuthFacade _iAuthFacade;

  Future<Option<User>> call() => _iAuthFacade.getSignedInUser();
}
