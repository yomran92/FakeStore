
import 'package:dio/dio.dart';

import '../configurations/app_configuration.dart';

class DioFactory {
  static Dio create() {
    final Map<String, String> headers = {};
    headers.addAll(AppConfigurations.BaseHeaders);

    headers.addAll({'Content-Type': 'application/json'});
    final baseOptions = BaseOptions(
      baseUrl: AppConfigurations.BaseUrl,
      headers: headers,
      sendTimeout: const Duration(
        seconds: 15,
      ),
      receiveTimeout: const Duration(
        seconds: 15,
      ),
      connectTimeout: const Duration(
        seconds: 15,
      ),
    );
    final dio = Dio(baseOptions);
    dio.interceptors.addAll([
     
    ]);
    return dio;
  }
}
