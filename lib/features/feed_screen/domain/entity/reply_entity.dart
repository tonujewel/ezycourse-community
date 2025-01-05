import 'package:equatable/equatable.dart';
import 'package:ezycourse_community/features/feed_screen/domain/entity/comments_entity.dart';

class ReplyDataEntity extends Equatable {
  final int id;
  final int schoolId;
  final int feedId;
  final int userId;
  final int replyCount;
  final int likeCount;
  final String commentTxt;
  final int parrentId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int isAuthorAndAnonymous;
  final UserEntity userEntity;

  const ReplyDataEntity({
    required this.id,
    required this.schoolId,
    required this.feedId,
    required this.userId,
    required this.replyCount,
    required this.likeCount,
    required this.commentTxt,
    required this.parrentId,
    required this.createdAt,
    required this.updatedAt,
    required this.isAuthorAndAnonymous,
    required this.userEntity,
  });

  @override
  List<Object?> get props => [
        id,
        schoolId,
        feedId,
        userId,
        replyCount,
        likeCount,
        commentTxt,
        parrentId,
        createdAt,
        updatedAt,
        isAuthorAndAnonymous,
        userEntity
      ];
}
