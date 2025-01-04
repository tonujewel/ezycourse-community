import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/networking/api_exceptions.dart';
import '../../../../core/networking/dio_client.dart';
import '../../../../core/networking/url_manager.dart';
import '../models/login_model.dart';
import '../models/login_request.dart';

abstract class LoginRemoteDatasources {
  Future<LoginModel> login(LoginRequest request);
}

class LoginRemoteDatasourcesImpl implements LoginRemoteDatasources {
  final DioClient client;

  LoginRemoteDatasourcesImpl({required this.client});

  @override
  Future<LoginModel> login(LoginRequest request) async {
    try {
      final result = await client.post(url: UrlManager.loginUrl, body: request.toJson());

      final res = LoginModel.fromJson(json.decode(result));
      return res;
    } on ApiException {
      rethrow;
    } on DioException catch (error) {
      var errorData = DioExceptionHandler.handleException(error);
      throw ApiException(message: errorData.message, statusCode: errorData.statusCode);
    } catch (e) {
      throw ApiException(message: e.toString(), statusCode: 505);
    }
  }
}
