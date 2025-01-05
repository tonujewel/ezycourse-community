import 'package:equatable/equatable.dart';
import 'package:ezycourse_community/core/utils/app_constant.dart';
import 'package:flutter/material.dart';

class FeedDataEntity extends Equatable {
  final int id;
  final int schoolId;
  final int userId;
  final int communityId;
  final String feedTxt;
  final String status;
  final String title;
  final int isPinned;
  final String fileType;
  final List<FileElementEntity> files;
  final int likeCount;
  final int commentCount;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int isBackground;
  final String? bgColor;
  final int spaceId;
  final DateTime publishDate;
  final String name;
  final String pic;
  final List<LikeTypeEntity> likeType;
  final bool isUserReacted;

  const FeedDataEntity(
      {required this.id,
      required this.schoolId,
      required this.userId,
      required this.communityId,
      required this.feedTxt,
      required this.status,
      required this.title,
      required this.isPinned,
      required this.fileType,
      required this.files,
      required this.likeCount,
      required this.commentCount,
      required this.createdAt,
      required this.updatedAt,
      required this.isBackground,
      required this.bgColor,
      required this.spaceId,
      required this.publishDate,
      required this.name,
      required this.pic,
      required this.likeType,
      required this.isUserReacted});

  @override
  List<Object?> get props => [
        id,
        schoolId,
        userId,
        communityId,
        feedTxt,
        status,
        title,
        isPinned,
        fileType,
        files,
        likeCount,
        commentCount,
        createdAt,
        updatedAt,
        isBackground,
        bgColor,
        spaceId,
        publishDate,
        name,
        pic,
        likeType,
        isUserReacted
      ];

  FileElementEntity? getSingleFile() {
    if (files.isNotEmpty) {
      return files.first;
    }
    return null;
  }

  // LinearGradient getGradiantCOlor() {

  //  for (var data in AppConstant.gradientsColor) {
     
  //  }
  // }
}

class FileElementEntity extends Equatable {
  final String fileLoc;
  final String originalName;
  final String extname;
  final String type;
  final int size;

  const FileElementEntity({
    required this.fileLoc,
    required this.originalName,
    required this.extname,
    required this.type,
    required this.size,
  });

  @override
  List<Object?> get props => [fileLoc, originalName, extname, type, size];
}

class LikeTypeEntity extends Equatable {
  final String reactionType;
  final int feedId;

  const LikeTypeEntity({
    required this.reactionType,
    required this.feedId,
  });

  @override
  List<Object?> get props => [reactionType, feedId];

  String getStatusImg() {
    switch (reactionType) {
      case "LIKE":
        return "assets/images/like.png";
      case "LOVE":
        return "assets/images/love.png";
      case "CARE":
        return "assets/images/care.png";
      case "HAHA":
        return "assets/images/haha.png";
      case "WOW":
        return "assets/images/wow.png";
      case "SAD":
        return "assets/images/sad.png";
      case "ANGRY":
        return "assets/images/angry.png";

      default:
        "assets/images/like.png";
    }

    return "";
  }
}

List<String> reactionTypes = ["LIKE", "LOVE", "CARE", "HAHA", "WOW", "SAD", "ANGRY"];
