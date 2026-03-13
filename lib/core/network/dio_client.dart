import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:path_provider/path_provider.dart';


import 'api_endpoints.dart';
import 'api_interceptor.dart';

class DioClient {

  static late PersistCookieJar cookieJar;

  static Future<void> init() async {

    final dir = await getApplicationDocumentsDirectory();

    cookieJar = PersistCookieJar(
      storage: FileStorage("${dir.path}/.cookies/"),
    );

    dio.interceptors.add(CookieManager(cookieJar));
  }

  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: ApiEndpoints.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),

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
        request: true,
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        error: true,
      ),
    );
}