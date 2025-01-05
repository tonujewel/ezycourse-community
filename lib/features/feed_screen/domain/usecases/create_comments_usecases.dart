import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../data/model/create_comments_req.dart';
import '../repositories/commets_repository.dart';

class CreateCommentsUsecases {
  final CommentsRepository repository;

  CreateCommentsUsecases({required this.repository});

  Future<Either<Failure, String>> call(CreateCommentsReq req) async {
    return await repository.createComments(req);
  }
}
