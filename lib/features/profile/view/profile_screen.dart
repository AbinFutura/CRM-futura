import 'package:flutter/material.dart';
import 'package:futura_crm_app/core/naviagtion/app_router.dart';
import 'package:futura_crm_app/core/theme/app_text_theme.dart';
import 'package:provider/provider.dart';


import '../../../core/theme/app_colors.dart';
import '../../auth/view_model.dart/auth_view_model.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final vm = context.watch<AuthViewModel>();
    final user = vm.user;

    if (user == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final textTheme = Theme.of(context).textTheme;

    return Scaffold(

      appBar: AppBar(
        title: const Text("Profile"),
      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(16),

        child: Column(

          children: [

            /// PROFILE AVATAR
            Container(
              height: 90,
              width: 90,

              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary,
              ),

              child: const Icon(
                Icons.person,
                size: 42,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 16),

            /// NAME
            Text(
              user.fullName ?? "",
              style: textTheme.titleLarge,
            ),

            const SizedBox(height: 4),

            /// ROLE
            Text(
              user.role ?? "",
              style: textTheme.bodySmall,
            ),

            const SizedBox(height: 30),

            /// INFO CARD
            Card(

              elevation: 2,

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),

              child: Padding(

                padding: const EdgeInsets.all(16),

                child: Column(

                  children: [

                    _profileRow(
                      icon: Icons.phone,
                      title: "Mobile",
                      value: user.mobileNumber ?? "",
                    ),

                    const Divider(),

                    _profileRow(
                      icon: Icons.business,
                      title: "Company",
                      value: user.companyName ?? "",
                    ),

                    const Divider(),

                    _profileRow(
                      icon: Icons.flag,
                      title: "Status",
                      value: user.status ?? "",
                    ),

                  ],

                ),
              ),
            ),

            const SizedBox(height: 40),

            /// LOGOUT BUTTON
            SizedBox(
              width: double.infinity,

              child: ElevatedButton(

                onPressed: () {
                  _showLogoutDialog(context);
                },

                child: const Text("Logout"),

              ),
            )

          ],
        ),
      ),
    );
  }

  Widget _profileRow({
    required IconData icon,
    required String title,
    required String value,
  }) {

    return Row(

      children: [

        Icon(icon, color: AppColors.primary),

        const SizedBox(width: 12),

        Expanded(
          child: Text(title),
        ),

        Text(value),

      ],
    );
  }
void _showLogoutDialog(BuildContext context) {

  showDialog(

    context: context,

    builder: (_) {

      return AlertDialog(

        backgroundColor: Colors.white,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),

        title: const Text(
          "Logout",
          style: AppTextTheme.dialogTitle,
        ),

        content: const Text(
          "Are you sure you want to logout?",
          style: AppTextTheme.dialogBody,
        ),

        actionsPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),

        actions: [

          Row(
            children: [

              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel"),
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: ElevatedButton(
                  onPressed: () async {

                    final vm = context.read<AuthViewModel>();

                    await vm.logout();

                    if (!context.mounted) return;

                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      MyAppRouter.login,
                      (route) => false,
                    );

                  },
                  child: const Text("Logout"),
                ),
              ),

            ],
          )

        ],
      );
    },
  );
}
}