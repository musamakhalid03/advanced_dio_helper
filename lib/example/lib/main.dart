import 'package:flutter/material.dart';
import 'package:advanced_dio_helper/advanced_dio_helper.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Advanced Dio Helper Example')),
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              final authController = AuthController();
              await authController.loginUser("test@example.com", "123456");

              final response = await AdvancedDioHelper.instance.get(
                "/users",               // positional parameter
                cacheKey: "users_list", // named optional parameter
              );

              debugPrint("Users: $response");
            },
            child: const Text("Run API Example"),
          ),
        ),
      ),
    );
  }
}
