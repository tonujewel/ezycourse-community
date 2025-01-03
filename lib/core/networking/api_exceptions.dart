import 'package:dio/dio.dart';

import '../errors/failure.dart';

// class ApiFailure {
//   final int? statusCode;
//   final String message;

//   ApiFailure({this.statusCode, required this.message});
// }

class DioExceptionHandler {
  static ApiFailure handleException(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return const ApiFailure(
          statusCode: 0,
          message: "Connection timeout. Please check your internet connection.",
        );
      case DioExceptionType.sendTimeout:
        return const ApiFailure(
          statusCode: 0,
          message: "Request timeout. Please try again.",
        );
      case DioExceptionType.receiveTimeout:
        return const ApiFailure(
          statusCode: 0,
          message: "Server took too long to respond.",
        );
      case DioExceptionType.badResponse:
        return _handleBadResponse(error.response);
      case DioExceptionType.cancel:
        return const ApiFailure(
          statusCode: 0,
          message: "Request was cancelled.",
        );
      case DioExceptionType.unknown:
        return const ApiFailure(
          statusCode: 0,
          message: "An unexpected error occurred. Please try again.",
        );
      default:
        return const ApiFailure(
          statusCode: 0,
          message: "An unknown error occurred.",
        );
    }
  }

  static ApiFailure _handleBadResponse(Response? response) {
    if (response == null) {
      return const ApiFailure(
        statusCode: 0,
        message: "Server response was null.",
      );
    }
    if (response.data != null && response.data is Map<String, dynamic>) {
      final errorMessage = response.data['msg'];
      return ApiFailure(
        statusCode: response.statusCode ?? 0,
        message: errorMessage ?? "Unexpected server response.",
      );
    }
    return ApiFailure(
      statusCode: response.statusCode ?? 0,
      message: _defaultMessageForStatusCode(response.statusCode),
    );
  }

  static String _defaultMessageForStatusCode(int? statusCode) {
    switch (statusCode) {
      case 400:
        return "Bad request. Please check your input.";
      case 401:
        return "Unauthorized. Please check your credentials.";
      case 403:
        return "Access denied. You do not have permission.";
      case 404:
        return "Resource not found.";
      case 500:
        return "Internal server error. Please try again later.";
      default:
        return "Unexpected error occurred with status code: $statusCode.";
    }
  }
}
