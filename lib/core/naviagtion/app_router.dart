import 'package:flutter/material.dart';
import 'package:futura_crm_app/features/leads/view/add_lead_screen.dart';
import 'package:futura_crm_app/features/navigation/root_screen.dart';
import '../../features/auth/view/login_screen.dart';
import '../../features/auth/view/splash_screen.dart';


class MyAppRouter {

  static const splash = "/";
  static const login = "/login";
  static const root = "/root";
  static const addLead = "/add-lead";

  static Route<dynamic> generateRoute(RouteSettings settings) {

    switch (settings.name) {

      case splash:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );

      case login:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );

      case root:
        return MaterialPageRoute(
          builder: (_) => const RootScreen(),
        );

      case addLead:
        return MaterialPageRoute(
          builder: (_) => const AddLeadScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );

    }

  }

}