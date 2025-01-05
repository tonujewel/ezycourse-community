import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';


class DioClient {
  static const int timeoutDuration = 60;

  final Dio _dio = Dio();

  //GET
  Future<dynamic> get({
    required String url,
    Map<String, dynamic>? params,
   required Map<String, dynamic>? header,
  }) async {
    try {
      var response = await _dio
          .get(
            url,
            options: Options(headers: header, contentType: 'application/json'),
            queryParameters: params,
          )
          .timeout(const Duration(seconds: timeoutDuration));
      printResponse(url, "${header ?? ""}", "", "$response");

      return jsonEncode(response.data);
    } catch (e) {
      printResponse(url, "${header ?? ""}", '', "$e");
      rethrow;
    }
  }

  //POST
  Future<dynamic> post({
    required String url,
    Map<String, dynamic>? params,
    Map<String, dynamic>? body,
    required Map<String, dynamic>? header,
  }) async {
    try {
      if (body != null) {
        var response = await _dio
            .post(url, options: Options(headers: header), queryParameters: params, data: body)
            .timeout(const Duration(seconds: timeoutDuration));

        printResponse(url, "${header ?? ""}", "$body", "$response");
        return jsonEncode(response.data);
      } else {
        var response = await _dio
            .post(url, options: Options(headers: header), queryParameters: params)
            .timeout(const Duration(seconds: timeoutDuration));

        printResponse(url, "${header ?? ""}", "$body", "$response");
        return jsonEncode(response.data);
      }
    } catch (e) {
      printResponse(url, "${header ?? ""}", jsonEncode(body), "$e");
      rethrow;
    }
  }

  void printResponse(String url, String header, String body, String response) {
    log("============================================================");
    log("URL : $url ");
    log("HEADER : $header ");
    log("BODY : $body ");
    log("RESPONSE==> : $response <===");
    log("============================================================");
  }
}
