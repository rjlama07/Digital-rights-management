import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:nepalihiphub/controller/auth_controller.dart';
import 'package:nepalihiphub/view/nav_bar/nav_bar.dart';

class MainLoginPage extends StatefulWidget {
  const MainLoginPage({super.key});

  @override
  State<MainLoginPage> createState() => _MainLoginPageState();
}

class _MainLoginPageState extends State<MainLoginPage> {
  late final TextEditingController email;
  late final TextEditingController controller1;

  @override
  void initState() {
    email = TextEditingController();
    controller1 = TextEditingController();

    super.initState();
  }

  Widget buildTextField({
    required String hintText,
    bool isObsecure = false,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(hintText),
        const SizedBox(height: 10),
        TextFormField(
          controller: controller,
          validator: (value) => value!.isEmpty ? "Field is required" : null,
          obscureText: isObsecure,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            fillColor: const Color(0xFF777777),
            filled: true,
            hintText: hintText,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Login", style: Theme.of(context).textTheme.titleLarge),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildTextField(
                hintText: "Email",
                controller: email,
              ),
              const SizedBox(
                height: 20,
              ),
              buildTextField(
                hintText: "Password",
                isObsecure: true,
                controller: controller1,
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    controller.login(email.text, controller1.text);
                  },
                  child: const Center(child: Text("Login"))),
            ],
          ),
        ),
      ),
    );
  }
}
