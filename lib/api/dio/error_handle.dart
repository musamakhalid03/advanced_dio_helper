import 'package:dio/dio.dart';

class ApiErrorHandler {
  static String handle(error) {
    if (error is String) return error;

    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return "Connection timeout. Please try again.";
        case DioExceptionType.sendTimeout:
          return "Server taking too long.";
        case DioExceptionType.receiveTimeout:
          return "Server not responding.";
        case DioExceptionType.badResponse:
          return error.response?.data["message"] ??
              "Server error occurred.";
        case DioExceptionType.connectionError:
          return "No internet connection.";
        default:
          return "Unexpected error occurred.";
      }
    }
    return "Something went wrong.";
  }
}
