import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/networking/api_exceptions.dart';
import '../../../../core/networking/dio_client.dart';
import '../../../../core/networking/url_manager.dart';
import '../../../../core/utils/shared_preference_utils.dart';
import '../model/crate_post_req.dart';

abstract class CreatePostDatasources {
  Future<String> createPost(CreatePostReq req);
}

class CreatePostDataSourceImpl implements CreatePostDatasources {
  final DioClient dioClient;

  CreatePostDataSourceImpl({required this.dioClient});

  @override
  Future<String> createPost(CreatePostReq req) async {
    Map<String, dynamic>? header = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${SharedPrefUtil.getBearerToken()}',
    };

    try {
      final result = await dioClient.post(url: UrlManager.createPostUrl, body: req.toJson(), header: header);
      log("result $result");
      return "Post successfully created";
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
