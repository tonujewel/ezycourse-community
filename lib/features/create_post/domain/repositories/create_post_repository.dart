import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../data/model/crate_post_req.dart';

abstract class CreatePostRepository {
  Future<Either<Failure, String>> createPost(CreatePostReq req);
}
