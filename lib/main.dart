import 'package:flutter/material.dart';
import 'package:futura_crm_app/core/naviagtion/app_router.dart';
import 'package:futura_crm_app/core/network/dio_client.dart';
import 'package:futura_crm_app/core/theme/app_theme.dart';

import 'package:futura_crm_app/features/auth/view_model.dart/auth_view_model.dart';
import 'package:futura_crm_app/features/leads/view_model/leads_viewmodel.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DioClient.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_)=> LeadsViewModel())
        ],
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

      theme:AppTheme.lightTheme,
      initialRoute: MyAppRouter.splash,
      onGenerateRoute: MyAppRouter.generateRoute,
    );
  }
}
