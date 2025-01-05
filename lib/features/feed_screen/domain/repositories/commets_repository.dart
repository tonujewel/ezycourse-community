import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../data/model/ceare_reply_req.dart';
import '../../data/model/create_comments_req.dart';
import '../entity/comments_entity.dart';
import '../entity/reply_entity.dart';

abstract class CommentsRepository {
  Future<Either<Failure, List<CommentsEntity>>> getCommentsById(String id);
  Future<Either<Failure, List<ReplyDataEntity>>> getRepliesById(String id);
  Future<Either<Failure, String>> createComments(CreateCommentsReq req);
  Future<Either<Failure, String>> createReplly(CreateReplyReq req);
}
