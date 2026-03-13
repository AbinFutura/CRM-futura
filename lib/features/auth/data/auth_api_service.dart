// import 'package:dio/dio.dart';
// import '../../../core/network/dio_client.dart';
// import '../../../core/network/api_endpoints.dart';

// class AuthApiService {

//   final Dio dio = DioClient.dio;

//   Future<Response> login(Map<String, dynamic> data) async {

//     return await dio.post(
//       ApiEndpoints.login,
//       data: data,
//     );

//   }

//   Future<Response> getProfile() async {

//     return await dio.get(
//       ApiEndpoints.getProfile,
//     );

//   }

//   Future<Response> logout() async {

//     return await dio.post(
//       ApiEndpoints.logout,
//     );

//   }

// }

import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/network/api_endpoints.dart';
import '../../../core/storage/token_storage.dart';

class AuthApiService {

  final Dio dio = DioClient.dio;

  Future<Response> login(Map<String, dynamic> data) async {

    return await dio.post(
      ApiEndpoints.login,
      data: data,
    );

  }

  Future<Response> getProfile() async {

    return await dio.get(
      ApiEndpoints.getProfile,
    );

  }

  Future<Response> logout() async {

    final token = await TokenStorage.getAccessToken();

    return await dio.post(
      ApiEndpoints.logout,
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
        },

        /// 🚫 Prevent interceptor refresh during logout
        extra: {
          "skipRefresh": true,
        },
      ),
    );

  }
}