import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'package:get/route_manager.dart';
import 'package:nepalihiphub/controller/auth_controller.dart';
import 'package:nepalihiphub/view/signup/signup.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthController());
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              const Text(
                "Login",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), label: Text("Email")),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), label: Text("Password")),
              ),
              const SizedBox(
                height: 10,
              ),
              Obx(
                () => ElevatedButton(
                  onPressed: () {
                    controller.login(
                        emailController.text, passwordController.text);
                  },
                  child: controller.isLoginLoading.value
                      ? const CircularProgressIndicator()
                      : const Text("Login"),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Not a Artist? "),
                  GestureDetector(
                    onTap: () {
                      Get.to(const SignUp());
                    },
                    child: const Text(
                      "Signup",
                      style: TextStyle(color: Colors.blue),
                    ),
                  )
                ],
              ),
              const Spacer()
            ],
          ),
        ),
      ),
    );
  }
}
