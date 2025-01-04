import 'package:dartz/dartz.dart';
import '../repositories/feed_repository.dart';

import '../../../../core/errors/failure.dart';
import '../entity/feed_data_entity.dart';

class GetFeedUsecases {
  final FeedRepository repository;

  GetFeedUsecases({required this.repository});

  Future<Either<Failure, List<FeedDataEntity>>> call() async {
    return await repository.getFeed();
  }
}
