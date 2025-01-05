import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entity/reply_entity.dart';
import '../repositories/commets_repository.dart';

class GetRepliesUsecases {
  final CommentsRepository repository;

  GetRepliesUsecases({required this.repository});

  Future<Either<Failure, List<ReplyDataEntity>>> call(String id) async {
    return await repository.getRepliesById(id);
  }
}
