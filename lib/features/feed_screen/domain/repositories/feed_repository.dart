import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../data/model/submit_react_req.dart';
import '../entity/feed_data_entity.dart';

abstract class FeedRepository {
  Future<Either<Failure, List<FeedDataEntity>>> getFeed(String? lastId);
  Future<Either<Failure, String>> submitReact(SubmitReactReq req);
}
