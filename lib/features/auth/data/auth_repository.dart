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

    final model =
        LoginResponseModel.fromJson(response.data);

    /// Save BOTH tokens
    await TokenStorage.saveTokens(
      accessToken: model.xToken,
      refreshToken: model.rToken ?? "",
    );

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