import 'package:equatable/equatable.dart';

class CommentsEntity extends Equatable {
  final int id;
  final int schoolId;
  final int feedId;
  final int userId;
  final int replyCount;
  final int likeCount;
  final String commentTxt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final UserEntity userEntity;

  const CommentsEntity(
      {required this.id,
      required this.schoolId,
      required this.feedId,
      required this.userId,
      required this.replyCount,
      required this.likeCount,
      required this.commentTxt,
      required this.createdAt,
      required this.updatedAt,
      required this.userEntity});

  @override
  List<Object?> get props =>
      [id, schoolId, feedId, userId, replyCount, likeCount, commentTxt, createdAt, updatedAt, userEntity];
}

class UserEntity extends Equatable {
  final int id;
  final String fullName;
  final String profilePic;
  final String userType;

  const UserEntity({
    required this.id,
    required this.fullName,
    required this.profilePic,
    required this.userType,
  });

  @override
  List<Object?> get props => [id, fullName, profilePic, userType];
}
