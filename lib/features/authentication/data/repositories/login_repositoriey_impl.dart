import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/login_entites.dart';
import '../../domain/repositories/login_repository.dart';
import '../datasources/login_remote_datasources.dart';
import '../models/login_request.dart';

class LoginRepositorieyImpl implements LoginRepository {
  final LoginRemoteDatasources datasources;

  LoginRepositorieyImpl({required this.datasources});

  @override
  Future<Either<Failure, LoginEntity>> doLogin(LoginRequest request) async {
    try {
      final result = await datasources.login(request);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }
}
