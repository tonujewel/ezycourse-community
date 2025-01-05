import 'package:ezycourse_community/features/feed_screen/domain/entity/comments_entity.dart';
import 'package:ezycourse_community/features/feed_screen/domain/entity/reply_entity.dart';

class CommentsWithReplyEntity {
  final CommentsEntity comments;

  final List<ReplyDataEntity> replies;

  const CommentsWithReplyEntity({
    required this.comments,
    required this.replies,
  });
}
