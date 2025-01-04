import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/networking/api_exceptions.dart';
import '../../../../core/networking/dio_client.dart';
import '../../../../core/networking/url_manager.dart';
import '../model/feed_data_model.dart';

abstract class FeedRemoteDataSrc {
  Future<List<FeedDataModel>> getFeeds();
}

class FeedRemoteDataSrcImpl implements FeedRemoteDataSrc {
  final DioClient dioClient;

  FeedRemoteDataSrcImpl({required this.dioClient});

  @override
  Future<List<FeedDataModel>> getFeeds() async {
    var body = {
      "community_id": 2914,
      "space_id": 5883,
      "more": 211542,
    };
    try {
      final result = await dioClient.post(url: UrlManager.feedUrl, body: body);

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
}
