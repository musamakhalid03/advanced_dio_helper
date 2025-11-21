import '../dio/advanced_dio_helper.dart';

class AuthRepository {
  final api = AdvancedDioHelper.instance;

  Future<dynamic> login(String email, String password) async {
    try {
      final response = await api.post("/auth/login", data: {
        "email": email,
        "password": password,
      });
      return response.data; 
    } catch (e) {
     
      rethrow;
    }
  }
}
