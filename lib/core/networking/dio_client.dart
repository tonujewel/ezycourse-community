import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ezycourse_community/core/utils/shared_preference_utils.dart';

class DioClient {
  static const int timeoutDuration = 60;

  final Dio _dio = Dio();

  Map<String, dynamic>? header = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${SharedPrefUtil.instance.getBearerToken()}',
  };

  //GET
  Future<dynamic> get({
    required String url,
    Map<String, dynamic>? params,
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

      return response.data;
    } catch (e) {
      printResponse(url, "${header ?? ""}", '', "$e");
      rethrow;
    }
  }

  //POST

  Future<dynamic> post({required String url, Map<String, dynamic>? params, dynamic body}) async {
    var payload = json.encode(body);
    try {
      var response = await _dio
          .post(
            url,
            options: Options(headers: header),
            queryParameters: params,
            data: payload,
          )
          .timeout(const Duration(seconds: timeoutDuration));
      printResponse(url, "${header ?? ""}", "$body", "$response");
      return jsonEncode(response.data);
    } catch (e) {
      printResponse(url, "${header ?? ""}", jsonEncode(body), "$e");
      rethrow;
    }
  }

  //PATCH

  Future<dynamic> patch(
      {required String url,
      // Map<String, dynamic>? header,
      Map<String, dynamic>? params,
      dynamic body}) async {
    var payload = json.encode(body);
    try {
      var response = await _dio
          .patch(url, options: Options(headers: header), queryParameters: params, data: payload)
          .timeout(const Duration(seconds: timeoutDuration));
      printResponse(url, "${header ?? ""}", "$body", "$response");
      return response.data;
    } catch (e) {
      printResponse(url, "${header ?? ""}", jsonEncode(body), "$e");
      rethrow;
    }
  }

  //DELETE

  Future<dynamic> delete(
      {required String url,
      // Map<String, dynamic>? header,
      Map<String, dynamic>? params,
      dynamic body}) async {
    var payload = json.encode(body);
    try {
      var response = await _dio
          .delete(url, options: Options(headers: header), queryParameters: params, data: payload)
          .timeout(const Duration(seconds: timeoutDuration));
      printResponse(url, "${header ?? ""}", "$body", "$response");
      return response.data;
    } catch (e) {
      printResponse(url, "${header ?? ""}", jsonEncode(body), "$e");
      rethrow;
    }
  }

  //MULTIPART FOR MULTIPLE FILE UPLOAD

  List<File>? docFileList = [];
  Future<dynamic> multipartRequest({
    required String url,
    required Map<String, dynamic> header,
    Map<String, dynamic>? params,
    required Map<String, dynamic> body,
    String? filepath,
  }) async {
    var formData = FormData.fromMap(body);
    for (var files in docFileList!) {
      filepath = files.path;
      formData.files.addAll([MapEntry("document[]", await MultipartFile.fromFile(filepath))]);
    }

    try {
      var response = await _dio
          .post(url, options: Options(headers: header), queryParameters: params, data: formData)
          .timeout(const Duration(seconds: timeoutDuration));
      printResponse(url, "$header ", "$body", "$response");
      return response.data;
    } catch (e) {
      printResponse(url, "$header", jsonEncode(body), "$e");
      rethrow;
    }
  }

  //MULTIPART FOR SINGLE FILE UPLOAD

  Future<dynamic> multipartSingleFile(
      {required String url,
      required Map<String, dynamic> header,
      Map<String, dynamic>? params,
      required Map<String, dynamic> body,
      String? filepath,
      required String key}) async {
    var formData = FormData.fromMap(body);
    if (filepath != null) {
      formData.files.add(MapEntry(key, await MultipartFile.fromFile(filepath)));
    }

    try {
      var response = await _dio
          .post(url, options: Options(headers: header), queryParameters: params, data: formData)
          .timeout(const Duration(seconds: timeoutDuration));
      printResponse(url, "$header ", "$body", "$response");
      return response.data;
    } catch (e) {
      printResponse(url, "$header", jsonEncode(body), "$e");
      rethrow;
    }
  }

  Future<dynamic> downloadPdf({required String url, required String fileName}) async {
    log("URL==> $fileName");
    log("URL==> $url");

    try {
      var response = await _dio
          .download(
            url,
            fileName,
          )
          .timeout(const Duration(seconds: timeoutDuration));
      log(response.toString());
      return "";
    } catch (e) {
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
