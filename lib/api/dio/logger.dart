import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class AppLogger {
  static const yellow = "\x1B[33m";
  static const reset = "\x1B[0m";

  static void request(RequestOptions options) {
    debugPrint("$yellow🔵 REQUEST → ${options.method} ${options.path}$reset");
    if (options.queryParameters.isNotEmpty) {
      debugPrint("$yellow 🔸 Query: ${options.queryParameters}$reset");
    }
    if (options.data != null) {
      debugPrint("$yellow 🔸 Body: ${options.data}$reset");
    }
  }

  static void response(Response response) {
    debugPrint(
        "$yellow🟢 RESPONSE (${response.statusCode}) → ${response.requestOptions.path}$reset");
    debugPrint("$yellow 🔸 Data: ${response.data}$reset");
  }

  static void error(DioException err) {
    debugPrint("$yellow🔴 ERROR → ${err.requestOptions.path}$reset");
    debugPrint("$yellow 🔸 Message: ${err.message}$reset");
    debugPrint("$yellow 🔸 Response: ${err.response?.data}$reset");
  }
}
