import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entity/comments_entity.dart';
import '../repositories/commets_repository.dart';

class GetCommentsUsecases {
  final CommentsRepository repository;

  GetCommentsUsecases({required this.repository});

  Future<Either<Failure, List<CommentsEntity>>> call(String id) async {
    return await repository.getCommentsById(id);
  }
}
