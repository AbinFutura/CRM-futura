import 'package:flutter/material.dart';
import 'package:futura_crm_app/features/auth/view/home_sceen.dart';
import 'package:futura_crm_app/features/auth/view_model.dart/auth_view_model.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/app_toast.dart';


class LoginScreen extends StatefulWidget {

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();

}

class _LoginScreenState extends State<LoginScreen> {

  final mobileController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final vm = context.watch<AuthViewModel>();

    return Scaffold(

      body: Center(

        child: Padding(
          padding: const EdgeInsets.all(24),

          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              const Text(
                "CRM Login",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF562B80),
                ),
              ),

              const SizedBox(height: 30),

              TextField(
                controller: mobileController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: "Mobile Number",
                ),
              ),

              const SizedBox(height: 16),

              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Password",
                ),
              ),

              const SizedBox(height: 30),

              if (vm.isLoading)
                const CircularProgressIndicator(),

              if (!vm.isLoading)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(

                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF562B80),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),

                    onPressed: () async {

                      final success = await vm.login(
                        mobileController.text,
                        passwordController.text,
                      );

                      if (success) {

                        if (!mounted) return;

                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const HomeScreen(),
                          ),
                          (route) => false,
                        );

                      } else {

                        AppToast.show(vm.error ?? "Login failed");

                      }

                    },

                    child: const Text(
                      "Login",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),

            ],
          ),
        ),
      ),
    );

  }

}