import 'package:dio/dio.dart';
import '../storage/token_storage.dart';
import 'api_endpoints.dart';
import 'dio_client.dart';

class ApiInterceptor extends Interceptor {

  bool _isRefreshing = false;

  @override
  void onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler) async {

    final token = await TokenStorage.getAccessToken();

    if (token != null && token.isNotEmpty) {
      options.headers["Authorization"] = "Bearer $token";
    }

    handler.next(options);
  }

  @override
  void onError(
      DioException err,
      ErrorInterceptorHandler handler) async {

    if (err.response?.statusCode == 401 && !_isRefreshing) {

      try {

        final newToken = await _refreshToken();

        final requestOptions = err.requestOptions;

        requestOptions.headers["Authorization"] =
            "Bearer $newToken";

        final retryResponse =
            await DioClient.dio.fetch(requestOptions);

        return handler.resolve(retryResponse);

      } catch (e) {

        await TokenStorage.clearToken();

        return handler.next(err);

      }

    }

    handler.next(err);
  }

  Future<String> _refreshToken() async {

    _isRefreshing = true;

    print("Refreshing access token...");

    final refreshToken = await TokenStorage.getRefreshToken();

    final refreshDio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
      ),
    );

    final response = await refreshDio.post(
      ApiEndpoints.refreshToken,
      data: {
        "rToken": refreshToken
      },
    );

    final newAccessToken = response.data["xToken"];
    final newRefreshToken = response.data["user"]["rToken"];

    await TokenStorage.saveTokens(
      accessToken: newAccessToken,
      refreshToken: newRefreshToken,
    );

    _isRefreshing = false;

    return newAccessToken;

  }

}