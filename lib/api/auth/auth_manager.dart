import 'package:dio/dio.dart';

class AuthManager {
  String? accessToken;
  String? refreshTokenStr;

  final Dio dio;

  AuthManager(this.dio);

  // 🔄 Refresh Token Implementation
  Future<bool> refreshToken() async {
    if (refreshTokenStr == null) return false;

    try {
      final res = await dio.post(
        "/auth/refresh",
        data: {"refresh_token": refreshTokenStr},
      );

      accessToken = res.data["access_token"];
      refreshTokenStr = res.data["refresh_token"];

      return true;
    } catch (_) {
      return false;
    }
  }

  // 🔁 Re-run failed request after refreshing token
  Future<Response?> retryRequest(DioException err) async {
    try {
      final options = err.requestOptions;

      final newHeaders = Map<String, dynamic>.from(options.headers);
      newHeaders["Authorization"] = "Bearer $accessToken";

      final newRequest = await dio.request(
        options.path,
        data: options.data,
        queryParameters: options.queryParameters,
        options: Options(
          method: options.method,
          headers: newHeaders,
        ),
      );

      return newRequest;
    } catch (_) {
      return null;
    }
  }
}
