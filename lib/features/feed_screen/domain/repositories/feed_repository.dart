import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entity/feed_data_entity.dart';

abstract class FeedRepository {
  Future<Either<Failure, List<FeedDataEntity>>> getFeed();
}
