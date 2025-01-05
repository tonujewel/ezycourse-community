import 'package:ezycourse_community/features/feed_screen/domain/entity/comments_entity.dart';

class CommentsModel extends CommentsEntity {
  const CommentsModel({
    required super.id,
    required super.schoolId,
    required super.feedId,
    required super.userId,
    required super.replyCount,
    required super.likeCount,
    required super.commentTxt,
    required super.createdAt,
    required super.updatedAt,
    required super.userEntity,
  });

  factory CommentsModel.fromJson(Map<String, dynamic> json) => CommentsModel(
        id: json["id"],
        schoolId: json["school_id"],
        feedId: json["feed_id"],
        userId: json["user_id"],
        replyCount: json["reply_count"],
        likeCount: json["like_count"],
        commentTxt: json["comment_txt"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        userEntity: UserModel.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "school_id": schoolId,
        "feed_id": feedId,
        "user_id": userId,
        "reply_count": replyCount,
        "like_count": likeCount,
        "comment_txt": commentTxt,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.fullName,
    required super.profilePic,
    required super.userType,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        fullName: json["full_name"],
        profilePic: json["profile_pic"],
        userType: json["user_type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": fullName,
        "profile_pic": profilePic,
        "user_type": userType,
      };
}
