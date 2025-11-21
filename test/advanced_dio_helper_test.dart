import 'package:flutter_test/flutter_test.dart';
import 'package:advanced_dio_helper/api/dio/advanced_dio_helper.dart';

void main() {
  test('DioHelper should be initialized', () {
    // Ensure the helper class can be constructed
    final dio = AdvancedDioHelper.instance;

    expect(dio, isNotNull);
  });
}
