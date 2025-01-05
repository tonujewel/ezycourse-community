import 'package:dartz/dartz.dart';
import '../../data/model/crate_post_req.dart';
import '../repositories/create_post_repository.dart';

import '../../../../core/errors/failure.dart';

class CreatePostUsecases {
  final CreatePostRepository repository;

  CreatePostUsecases({required this.repository});

  Future<Either<Failure, String>> call(CreatePostReq req) {
    return repository.createPost(req);
  }
}
