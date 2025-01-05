import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/repositories/create_post_repository.dart';
import '../datasources/create_post_datasources.dart';
import '../model/crate_post_req.dart';

class CreatePostRepositoryImpl implements CreatePostRepository {
  final CreatePostDatasources dataSource;

  CreatePostRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, String>> createPost(CreatePostReq req) async {
    try {
      final result = await dataSource.createPost(req);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }
}
