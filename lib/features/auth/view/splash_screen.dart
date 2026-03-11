import 'package:flutter/material.dart';
import 'package:futura_crm_app/features/auth/view/home_sceen.dart';
import 'package:futura_crm_app/features/auth/view_model.dart/auth_view_model.dart';
import 'package:provider/provider.dart';
import '../../../core/storage/token_storage.dart';

import '../view/login_screen.dart';


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

  void _goToLogin() {

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const LoginScreen(),
      ),
    );

  }

  void _goToHome() {

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const HomeScreen(),
      ),
    );

  }

  @override
  Widget build(BuildContext context) {

    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );

  }

}