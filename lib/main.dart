import 'package:flutter/material.dart';

import 'package:futura_crm_app/features/auth/view_model.dart/auth_view_model.dart';
import 'package:provider/provider.dart';
import 'features/auth/view/splash_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthViewModel())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        primaryColor: const Color(0xFF562B80),

        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF562B80)),

        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF562B80),
          foregroundColor: Colors.white,
        ),
      ),

      home: const SplashScreen(),
    );
  }
}
