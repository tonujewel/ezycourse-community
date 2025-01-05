import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ezycourse_community/features/feed_screen/data/model/create_comments_req.dart';
import 'package:ezycourse_community/features/feed_screen/data/model/reply_data_model.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/networking/api_exceptions.dart';
import '../../../../core/networking/dio_client.dart';
import '../../../../core/networking/url_manager.dart';
import '../../../../core/utils/shared_preference_utils.dart';
import '../model/ceare_reply_req.dart';
import '../model/comments_model.dart';

abstract class CommentRemoteDataSrc {
  Future<List<CommentsModel>> getComments(String id);
  Future<List<ReplyDataModel>> getReplies(String id);
  Future<String> createComments(CreateCommentsReq req);
  Future<String> createReply(CreateReplyReq req);
}

class CommentRemoteDataSrcImpl implements CommentRemoteDataSrc {
  final DioClient dioClient;

  CommentRemoteDataSrcImpl({required this.dioClient});

  @override
  Future<List<CommentsModel>> getComments(String id) async {
    Map<String, dynamic>? header = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${SharedPrefUtil.getBearerToken()}',
    };
    try {
      final result = await dioClient.get(url: "${UrlManager.getCommentsUrl}$id", header: header);

      final data = List<CommentsModel>.from(json.decode(result).map((x) => CommentsModel.fromJson(x)));

      return data;
    } on ApiException {
      rethrow;
    } on DioException catch (e) {
      final errorData = DioExceptionHandler.handleException(e);
      throw ApiException(message: errorData.message, statusCode: errorData.statusCode);
    } catch (e) {
      throw ApiException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<List<ReplyDataModel>> getReplies(String id) async {
    Map<String, dynamic>? header = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${SharedPrefUtil.getBearerToken()}',
    };
    try {
      final result = await dioClient.get(url: "${UrlManager.getRepliesUrl}$id", header: header);

      final data = List<ReplyDataModel>.from(json.decode(result).map((x) => ReplyDataModel.fromJson(x)));

      return data;
    } on ApiException {
      rethrow;
    } on DioException catch (e) {
      final errorData = DioExceptionHandler.handleException(e);
      throw ApiException(message: errorData.message, statusCode: errorData.statusCode);
    } catch (e) {
      throw ApiException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<String> createComments(CreateCommentsReq req) async {
    Map<String, dynamic>? header = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${SharedPrefUtil.getBearerToken()}',
    };

    try {
      final result = await dioClient.post(url: UrlManager.createCommentsUrl, body: req.toJson(), header: header);

      log(result.toString());
      return "Comments successfully created";
    } on ApiException {
      rethrow;
    } on DioException catch (e) {
      final errorData = DioExceptionHandler.handleException(e);
      throw ApiException(message: errorData.message, statusCode: errorData.statusCode);
    } catch (e) {
      throw ApiException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<String> createReply(CreateReplyReq req) async {
    Map<String, dynamic>? header = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${SharedPrefUtil.getBearerToken()}',
    };

    try {
      final result = await dioClient.post(url: UrlManager.createCommentsUrl, body: req.toJson(), header: header);

      log(result.toString());
      return "Reply successfully created";
    } on ApiException {
      rethrow;
    } on DioException catch (e) {
      final errorData = DioExceptionHandler.handleException(e);
      throw ApiException(message: errorData.message, statusCode: errorData.statusCode);
    } catch (e) {
      throw ApiException(message: e.toString(), statusCode: 505);
    }
  }
}
