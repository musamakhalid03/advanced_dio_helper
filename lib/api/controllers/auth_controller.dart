import 'package:advanced_dio_helper/api/auth/auth_repository.dart';
import 'package:advanced_dio_helper/api/dio/advanced_dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final AuthRepository repo = AuthRepository();

  var loading = false.obs;
  var errorMessage = ''.obs;

  // Login function
  Future<void> loginUser(String email, String password) async {
    loading.value = true;
    errorMessage.value = '';

    try {
      final res = await repo.login(email, password);


      final accessToken = res['access_token'];
      final refreshToken = res['refresh_token'];

      if (accessToken != null) {
        AdvancedDioHelper.instance.authManager.accessToken = accessToken;
      }
      if (refreshToken != null) {
        AdvancedDioHelper.instance.authManager.refreshTokenStr = refreshToken;
      }

      debugPrint("✅ Login Success: $res");
      Get.snackbar(
        "Success",
        "Logged in successfully!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      debugPrint("❌ Login Error: $e");
      errorMessage.value = e.toString();

      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      loading.value = false;
    }
  }
}
