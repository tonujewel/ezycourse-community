import 'package:dartz/dartz.dart';
import 'package:ezycourse_community/features/authentication/domain/entities/logout_entity.dart';

import '../../../../core/errors/failure.dart';
import '../../data/models/login_request.dart';
import '../entities/login_entites.dart';

abstract class LoginRepository {
  Future<Either<Failure, LoginEntity>> doLogin(LoginRequest request);
  Future<Either<Failure, LogoutEntity>> doLogout();

}
