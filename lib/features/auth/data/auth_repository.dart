import '../model/login_request_model.dart';
import '../model/login_response_model.dart';
import '../model/user_model.dart';
import '../../../core/storage/token_storage.dart';
import 'auth_api_service.dart';

class AuthRepository {

  final AuthApiService _apiService = AuthApiService();

Future<LoginResponseModel> login(
    String mobileNumber,
    String password) async {

  final request = LoginRequestModel(
    mobileNumber: mobileNumber,
    password: password,
  );

  final response =
      await _apiService.login(request.toJson());

  print("LOGIN RESPONSE HEADERS: ${response.headers.map}");

  final model =
      LoginResponseModel.fromJson(response.data);

  await TokenStorage.saveAccessToken(model.xToken);

  return model;
}

  Future<UserModel> getProfile() async {

    final response = await _apiService.getProfile();

    final userData = response.data["data"];

    return UserModel.fromJson(userData);

  }

  Future<void> logout() async {

    await _apiService.logout();

    await TokenStorage.clearToken();
    
  }

}
