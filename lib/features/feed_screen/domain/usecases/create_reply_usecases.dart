import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../data/model/ceare_reply_req.dart';
import '../repositories/commets_repository.dart';

class CreateReplyUsecases {
  final CommentsRepository repository;

  CreateReplyUsecases({required this.repository});

  Future<Either<Failure, String>> call(CreateReplyReq req) async {
    return await repository.createReplly(req);
  }
}
