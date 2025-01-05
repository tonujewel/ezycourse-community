import 'package:dartz/dartz.dart';
import 'package:ezycourse_community/features/authentication/domain/entities/logout_entity.dart';

import '../../../../core/errors/failure.dart';
import '../../data/models/login_request.dart';
import '../entities/login_entites.dart';
import '../repositories/login_repository.dart';

class LoginUsecases {
  final LoginRepository repository;

  LoginUsecases({required this.repository});

  Future<Either<Failure, LoginEntity>> call(LoginRequest request) {
    return repository.doLogin(request);
  }
}

class LogoutUsecases {
  final LoginRepository repository;

  LogoutUsecases({required this.repository});

  Future<Either<Failure, LogoutEntity>> call() {
    return repository.doLogout();
  }
}
