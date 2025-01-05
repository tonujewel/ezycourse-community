class CreatePostReq {
  final String feedTxt;
  final String communityId;
  final String spaceId;
  final String uploadType;
  final String activityType;
  final int isBackground;
  final String? bgColor;

  CreatePostReq({
    required this.feedTxt,
    required this.communityId,
    required this.spaceId,
    required this.uploadType,
    required this.activityType,
    required this.isBackground,
    required this.bgColor,
  });

  Map<String, dynamic> toJson() => {
        "feed_txt": feedTxt,
        "community_id": communityId,
        "space_id": spaceId,
        "uploadType": uploadType,
        "activity_type": activityType,
        "is_background": isBackground,
        "bg_color": bgColor,
      };
}
