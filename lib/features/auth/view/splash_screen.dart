import 'package:flutter/material.dart';
import 'package:futura_crm_app/core/naviagtion/app_router.dart';
import 'package:futura_crm_app/features/auth/view_model.dart/auth_view_model.dart';
import 'package:provider/provider.dart';
import '../../../core/storage/token_storage.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkSession();
  }

  Future<void> _checkSession() async {
    final token = await TokenStorage.getAccessToken();

    if (token == null) {
      _goToLogin();
      return;
    }

    final vm = context.read<AuthViewModel>();

    try {
      await vm.loadUser();

      _goToHome();
    } catch (e) {
      _goToLogin();
    }
  }

  _goToLogin() {
    Navigator.pushReplacementNamed(context, MyAppRouter.login);
  }

  _goToHome() {
    Navigator.pushReplacementNamed(context, MyAppRouter.root);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
