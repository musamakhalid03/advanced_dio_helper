import 'package:advanced_dio_helper/api/auth/auth_manager.dart';
import 'package:advanced_dio_helper/api/dio/token_interceptor.dart';
import 'package:dio/dio.dart';

class AdvancedDioHelper {
  static final AdvancedDioHelper instance = AdvancedDioHelper._internal();
  late Dio dio;
  late AuthManager authManager;

  AdvancedDioHelper._internal() {
    dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
        validateStatus: (status) =>
            status != null && status >= 200 && status <= 500,
      ),
    );

    authManager = AuthManager(dio);

    dio.interceptors.add(TokenInterceptor(authManager));
  }

  Future<Response> get(String url,
      {Map<String, dynamic>? queryParams}) async {
    return await dio.get(url, queryParameters: queryParams);
  }

  Future<Response> post(String url, {dynamic data}) async {
    return await dio.post(url, data: data);
  }

  Future<Response> put(String url, {dynamic data}) async {
    return await dio.put(url, data: data);
  }

  Future<Response> delete(String url, {dynamic data}) async {
    return await dio.delete(url, data: data);
  }
}
