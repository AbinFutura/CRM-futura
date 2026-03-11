import 'package:dio/dio.dart';
import 'api_endpoints.dart';
import 'api_interceptor.dart';

class DioClient {

  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: ApiEndpoints.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),

      /// allow interceptor to handle 401 instead of throwing
      validateStatus: (status) {
        return status != null && status < 500;
      },

      headers: {
        "Content-Type": "application/json",
      },
    ),
  )
    ..interceptors.add(ApiInterceptor())
    ..interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
      ),
    );
}