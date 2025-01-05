class CreateCommentsReq {
  final int feedId;
  final int feedUserId;
  final String commentTxt;
  final String commentSource;

  CreateCommentsReq({
    required this.feedId,
    required this.feedUserId,
    required this.commentTxt,
    required this.commentSource,
  });

  Map<String, dynamic> toJson() => {
        "feed_id": feedId,
        "feed_user_id": feedUserId,
        "comment_txt": commentTxt,
        "commentSource": commentSource,
      };
}
