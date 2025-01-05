import 'package:dartz/dartz.dart';
import 'package:ezycourse_community/features/feed_screen/data/model/ceare_reply_req.dart';
import 'package:ezycourse_community/features/feed_screen/data/model/create_comments_req.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entity/comments_entity.dart';
import '../../domain/entity/reply_entity.dart';
import '../../domain/repositories/commets_repository.dart';
import '../datasources/comment_remote_data_src.dart';

class CommentRepositoryImpl implements CommentsRepository {
  final CommentRemoteDataSrc dataSrc;

  CommentRepositoryImpl({required this.dataSrc});

  @override
  Future<Either<Failure, List<CommentsEntity>>> getCommentsById(String id) async {
    try {
      final result = await dataSrc.getComments(id);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, List<ReplyDataEntity>>> getRepliesById(String id) async {
    try {
      final result = await dataSrc.getReplies(id);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, String>> createComments(CreateCommentsReq req) async {
    try {
      final result = await dataSrc.createComments(req);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, String>> createReplly(CreateReplyReq req) async {
    try {
      final result = await dataSrc.createReply(req);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }
}
