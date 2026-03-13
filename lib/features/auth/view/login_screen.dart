import 'package:flutter/material.dart';
import 'package:futura_crm_app/core/naviagtion/app_router.dart';
import 'package:futura_crm_app/core/theme/app_colors.dart';
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

  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {

    final vm = context.watch<AuthViewModel>();
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(

      body: Center(

        child: Padding(
          padding: const EdgeInsets.all(24),

          child: SingleChildScrollView(

            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                /// CRM ICON
                Container(
                  height: 90,
                  width: 90,

                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,

                    boxShadow: [
                      BoxShadow(
                        blurRadius: 20,
                        color: Colors.black12,
                        offset: Offset(0, 8),
                      )
                    ],
                  ),

                  child: const Icon(
                    Icons.people_alt_outlined,
                    size: 42,
                    color: AppColors.primary,
                  ),
                ),

                const SizedBox(height: 20),

                /// TITLE
                Text(
                  "CRM Login",
                  style: textTheme.titleLarge?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 30),

                /// MOBILE FIELD
                TextField(
                  controller: mobileController,
                  keyboardType: TextInputType.phone,

                  decoration: const InputDecoration(
                    hintText: "Mobile Number",
                    prefixIcon: Icon(Icons.phone),
                  ),
                ),

                const SizedBox(height: 16),

                /// PASSWORD FIELD
                TextField(
                  controller: passwordController,
                  obscureText: _obscurePassword,

                  decoration: InputDecoration(
                    hintText: "Password",
                    prefixIcon: const Icon(Icons.lock),

                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),

                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                if (vm.isLoading)
                  const CircularProgressIndicator(),

                if (!vm.isLoading)
                  SizedBox(
                    width: double.infinity,

                    child: ElevatedButton(

                      onPressed: () async {

                        final success = await vm.login(
                          mobileController.text,
                          passwordController.text,
                        );

                        if (success) {

                          if (!mounted) return;

                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            MyAppRouter.root,
                            (route) => false,
                          );

                        } else {

                          AppToast.show(vm.error ?? "Login failed");

                        }

                      },

                      child: const Text("Login"),

                    ),
                  ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}