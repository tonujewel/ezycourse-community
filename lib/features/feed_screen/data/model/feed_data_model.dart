import '../../domain/entity/feed_data_entity.dart';

class FeedDataModel extends FeedDataEntity {
  const FeedDataModel({
    required super.id,
    required super.schoolId,
    required super.userId,
    required super.communityId,
    required super.feedTxt,
    required super.status,
    required super.title,
    required super.isPinned,
    required super.fileType,
    required super.files,
    required super.likeCount,
    required super.commentCount,
    required super.createdAt,
    required super.updatedAt,
    required super.isBackground,
    required super.bgColor,
    required super.spaceId,
    required super.publishDate,
    required super.name,
    required super.pic,
    required super.likeType,
    required super.isUserReacted,
  });

  factory FeedDataModel.fromJson(Map<String, dynamic> json) => FeedDataModel(
        id: json["id"],
        schoolId: json["school_id"],
        userId: json["user_id"],
        communityId: json["community_id"],
        feedTxt: json["feed_txt"],
        status: json["status"],
        title: json["title"],
        isPinned: json["is_pinned"],
        fileType: json["file_type"],
        files: List<FileElementModel>.from(json["files"].map((x) => FileElementModel.fromJson(x))),
        likeCount: json["like_count"],
        commentCount: json["comment_count"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        isBackground: json["is_background"],
        bgColor: json["bg_color"],
        spaceId: json["space_id"],
        publishDate: DateTime.parse(json["publish_date"]),
        name: json["name"],
        pic: json["pic"],
        likeType: List<LikeTypeModel>.from(json["likeType"].map((x) => LikeTypeModel.fromJson(x))),
        isUserReacted: json["isUserReacted"] ?? false,
      );
}

class FileElementModel extends FileElementEntity {
  const FileElementModel({
    required super.fileLoc,
    required super.originalName,
    required super.extname,
    required super.type,
    required super.size,
  });

  factory FileElementModel.fromJson(Map<String, dynamic> json) => FileElementModel(
        fileLoc: json["fileLoc"],
        originalName: json["originalName"],
        extname: json["extname"],
        type: json["type"],
        size: json["size"],
      );

  Map<String, dynamic> toJson() => {
        "fileLoc": fileLoc,
        "originalName": originalName,
        "extname": extname,
        "type": type,
        "size": size,
      };
}

class LikeTypeModel extends LikeTypeEntity {
  const LikeTypeModel({
    required super.reactionType,
    required super.feedId,
  });

  factory LikeTypeModel.fromJson(Map<String, dynamic> json) => LikeTypeModel(
        reactionType: json["reaction_type"],
        feedId: json["feed_id"],
      );

  Map<String, dynamic> toJson() => {"reaction_type": reactionType, "feed_id": feedId};
}
