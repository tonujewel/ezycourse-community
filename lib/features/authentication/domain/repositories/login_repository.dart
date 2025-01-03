import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../data/models/login_request.dart';
import '../entities/login_entites.dart';

// abstract class LoginRepository {
//   Future<LoginEntity> doLogin(LoginRequest request);
// }

abstract class LoginRepository {
  Future<Either<Failure, LoginEntity>> doLogin(LoginRequest request);
}
