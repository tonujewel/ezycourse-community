import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entity/feed_data_entity.dart';
import '../../domain/repositories/feed_repository.dart';
import '../datasources/feed_remote_data_src.dart';

class FeedRepositoryImpl implements FeedRepository {
  final FeedRemoteDataSrc dataSrc;

  FeedRepositoryImpl({required this.dataSrc});

  @override
  Future<Either<Failure, List<FeedDataEntity>>> getFeed() async {
    try {
      final result = await dataSrc.getFeeds();
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }
}
