// To parse this JSON data, do
//
//     final replyDataModel = replyDataModelFromJson(jsonString);

import 'dart:convert';

import 'package:ezycourse_community/features/feed_screen/domain/entity/reply_entity.dart';

import 'comments_model.dart';

List<ReplyDataModel> replyDataModelFromJson(String str) =>
    List<ReplyDataModel>.from(json.decode(str).map((x) => ReplyDataModel.fromJson(x)));

String replyDataModelToJson(List<ReplyDataModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ReplyDataModel extends ReplyDataEntity {
  const ReplyDataModel(
      {required super.id,
      required super.schoolId,
      required super.feedId,
      required super.userId,
      required super.replyCount,
      required super.likeCount,
      required super.commentTxt,
      required super.parrentId,
      required super.createdAt,
      required super.updatedAt,
      required super.isAuthorAndAnonymous,
      required super.userEntity});

  factory ReplyDataModel.fromJson(Map<String, dynamic> json) => ReplyDataModel(
        id: json["id"],
        schoolId: json["school_id"],
        feedId: json["feed_id"],
        userId: json["user_id"],
        replyCount: json["reply_count"],
        likeCount: json["like_count"],
        commentTxt: json["comment_txt"],
        parrentId: json["parrent_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        isAuthorAndAnonymous: json["is_author_and_anonymous"],
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
        "parrent_id": parrentId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "is_author_and_anonymous": isAuthorAndAnonymous,
      };
}
