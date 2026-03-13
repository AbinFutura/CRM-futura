// import 'package:dio/dio.dart';
// import 'package:dio_cookie_manager/dio_cookie_manager.dart';

// import '../storage/token_storage.dart';
// import 'api_endpoints.dart';
// import 'dio_client.dart';

// class ApiInterceptor extends Interceptor {

//   bool _isRefreshing = false;

//   @override
//   void onRequest(
//     RequestOptions options,
//     RequestInterceptorHandler handler,
//   ) async {

//     final token = await TokenStorage.getAccessToken();

//     if (token != null) {
//       options.headers["Authorization"] = "Bearer $token";
//     }

//     handler.next(options);
//   }

//   @override
//   void onResponse(
//     Response response,
//     ResponseInterceptorHandler handler,
//   ) async {

//     if (response.statusCode == 401 ||
//         (response.data is Map &&
//          response.data["message"] == "Invalid or expired token")) {

//       try {

//         final newToken = await _refreshToken();

//         final requestOptions = response.requestOptions;

//         requestOptions.headers["Authorization"] = "Bearer $newToken";

//         final retryResponse =
//             await DioClient.dio.fetch(requestOptions);

//         return handler.resolve(retryResponse);

//       } catch (e) {

//         await TokenStorage.clearToken();

//         return handler.next(response);

//       }

//     }

//     handler.next(response);
//   }

//   Future<String> _refreshToken() async {

//     if (_isRefreshing) {
//       throw Exception("Refresh already running");
//     }

//     _isRefreshing = true;

//     print("Refreshing access token...");

//     final refreshDio = Dio(
//       BaseOptions(
//         baseUrl: ApiEndpoints.baseUrl,
//       ),
//     )

//       /// attach same cookie jar
//       ..interceptors.add(
//         CookieManager(DioClient.cookieJar),
//       );

//     final response = await refreshDio.post(
//       ApiEndpoints.refreshToken,
//     );

//     print("REFRESH RESPONSE: ${response.data}");

//     final newAccessToken = response.data["xToken"];

//     await TokenStorage.saveAccessToken(newAccessToken);

//     _isRefreshing = false;

//     return newAccessToken;
//   }
// }
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

import '../storage/token_storage.dart';
import 'api_endpoints.dart';
import 'dio_client.dart';

class ApiInterceptor extends Interceptor {

  bool _isRefreshing = false;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {

    final token = await TokenStorage.getAccessToken();

    if (token != null) {
      options.headers["Authorization"] = "Bearer $token";
    }

    handler.next(options);
  }

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {

    /// 🚫 Skip refresh logic for logout request
    if (response.requestOptions.extra["skipRefresh"] == true) {
      return handler.next(response);
    }

    if (response.statusCode == 401 ||
        (response.data is Map &&
         response.data["message"] == "Invalid or expired token")) {

      try {

        final newToken = await _refreshToken();

        final requestOptions = response.requestOptions;

        requestOptions.headers["Authorization"] = "Bearer $newToken";

        final retryResponse =
            await DioClient.dio.fetch(requestOptions);

        return handler.resolve(retryResponse);

      } catch (e) {

        await TokenStorage.clearToken();

        return handler.next(response);

      }

    }

    handler.next(response);
  }

  Future<String> _refreshToken() async {

    if (_isRefreshing) {
      throw Exception("Refresh already running");
    }

    _isRefreshing = true;

    print("Refreshing access token...");

    final refreshDio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
      ),
    )

      /// attach same cookie jar
      ..interceptors.add(
        CookieManager(DioClient.cookieJar),
      );

    final response = await refreshDio.post(
      ApiEndpoints.refreshToken,
    );

    print("REFRESH RESPONSE: ${response.data}");

    final newAccessToken = response.data["xToken"];

    await TokenStorage.saveAccessToken(newAccessToken);

    _isRefreshing = false;

    return newAccessToken;
  }
}