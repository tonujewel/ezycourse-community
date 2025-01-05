import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/networking/api_exceptions.dart';
import '../../../../core/networking/dio_client.dart';
import '../../../../core/networking/url_manager.dart';
import '../../../../core/utils/shared_preference_utils.dart';
import '../model/feed_data_model.dart';
import '../model/submit_react_req.dart';

abstract class FeedRemoteDataSrc {
  Future<List<FeedDataModel>> getFeeds(String? lastId);
  Future<String> submitReact(SubmitReactReq req);
}

class FeedRemoteDataSrcImpl implements FeedRemoteDataSrc {
  final DioClient dioClient;

  FeedRemoteDataSrcImpl({required this.dioClient});

  @override
  Future<List<FeedDataModel>> getFeeds(String? lastId) async {
    Map<String, dynamic>? header = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${SharedPrefUtil.getBearerToken()}',
    };
    var body = {
      "community_id": 2914,
      "space_id": 5883,
      "more": lastId,
    };

    try {
      final result = await dioClient.post(url: UrlManager.feedUrl, body: body, header: header);

      final data = List<FeedDataModel>.from(json.decode(result).map((x) => FeedDataModel.fromJson(x)));

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
  Future<String> submitReact(SubmitReactReq req) async {
    Map<String, dynamic>? header = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${SharedPrefUtil.getBearerToken()}',
    };

    try {
      final result = await dioClient.post(url: UrlManager.createLikeUrl, body: req.toJson(), header: header);
      log("result $result");
      return "Success";
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
