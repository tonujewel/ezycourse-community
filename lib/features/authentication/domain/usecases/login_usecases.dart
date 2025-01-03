import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../data/models/login_request.dart';
import '../entities/login_entites.dart';
import '../repositories/login_repository.dart';

class LoginUsecases {
  final LoginRepository repositories;

  LoginUsecases({required this.repositories});

  Future<Either<Failure, LoginEntity>> call(LoginRequest request) {
    return repositories.doLogin(request);
  }
}
