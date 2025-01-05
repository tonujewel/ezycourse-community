class SubmitReactReq {
  final int feedId;
  final String action;
  final String reactionType;
  final String reactionSource;

  SubmitReactReq({
    required this.feedId,
    required this.action,
    required this.reactionType,
    required this.reactionSource,
  });

  Map<String, dynamic> toJson() => {
        "feed_id": feedId,
        "action": action,
        "reaction_type": reactionType,
        "reactionSource": reactionSource,
      };
}
