import 'package:flutter/material.dart';
import '../data/auth_repository.dart';
import '../model/user_model.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthRepository _repository = AuthRepository();

  bool isLoading = false;
  String? error;
  UserModel? user;

  /// LOGIN
  Future<bool> login(String mobile, String password) async {
    try {
      isLoading = true;
      error = null;
      notifyListeners();

      await _repository.login(mobile, password);

      user = await _repository.getProfile();

      isLoading = false;
      notifyListeners();

      return true;
    } catch (e) {
      error = e.toString();

      isLoading = false;
      notifyListeners();

      return false;
    }
  }

  /// LOAD USER (SESSION CHECK)

  Future<void> loadUser() async {
    try {
      isLoading = true;
      notifyListeners();

      user = await _repository.getProfile();
    } catch (e) {
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    try {
      await _repository.logout();

      user = null;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
