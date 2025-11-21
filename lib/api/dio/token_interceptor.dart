import 'package:advanced_dio_helper/api/auth/auth_manager.dart';
import 'package:advanced_dio_helper/api/dio/logger.dart';
import 'package:dio/dio.dart';

class TokenInterceptor extends Interceptor {
  final AuthManager authManager;

  TokenInterceptor(this.authManager);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    String? token = authManager.accessToken;

    if (token != null) {
      options.headers["Authorization"] = "Bearer $token";
    }

    AppLogger.request(options);
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    AppLogger.response(response);
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    AppLogger.error(err);

    // Unauthorized → try refresh
    if (err.response?.statusCode == 401 &&
        !err.requestOptions.path.contains("/auth/refresh")) {
      
      final refreshed = await authManager.refreshToken.call();

      if (refreshed) {
        final retryReq = await authManager.retryRequest.call(err);
        if (retryReq != null) {
          return handler.resolve(retryReq);
        }
      }
    }

    handler.next(err);
  }
}
