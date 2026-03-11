import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:futura_crm_app/core/network/dio_client.dart';
import 'package:futura_crm_app/features/auth/view_model.dart/auth_view_model.dart';
import 'package:provider/provider.dart';
import '../../auth/view/login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AuthViewModel>();

    final user = vm.user;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text("CRM Dashboard"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await vm.logout();

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (route) => false,
              );
            },
          ),
        ],
      ),

      body: user == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(20),
              child: Card(
                elevation: 3,

                child: Padding(
                  padding: const EdgeInsets.all(20),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.fullName,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text("Mobile: ${user.mobileNumber}"),
                      Text("Role: ${user.role}"),
                      Text("Status: ${user.status}"),

                      const Divider(height: 30),

                      const Text(
                        "Company Details",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text("Name: ${user.companyName}"),
                      Text("Phone: ${user.companyPhone}"),
                      Text("Address: ${user.companyAddress}"),
                    ElevatedButton(
onPressed: () async {

  try {

    final response =
        await DioClient.dio.get("/user/me");

    print("USER DATA: ${response.data}");

  } catch (e) {

    print("ERROR: $e");

  }

},
  child: const Text("Test API"),
),
                      ElevatedButton(
  onPressed: () async {
    final dio = Dio(
      BaseOptions(
        baseUrl: "https://futura-crm.vercel.app/api/v1",
      ),
    );

    final response = await dio.post("/user/rtoken");

    print("REFRESH RESPONSE: ${response.data}");
  },
  child: const Text("Test Refresh"),
)
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
