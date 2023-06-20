import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nepalihiphub/controller/auth_controller.dart';

import 'package:nepalihiphub/view/login/login.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();
    final firstNameController = TextEditingController();
    final lastNameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPassswordController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return Scaffold(
        body: SafeArea(
      child: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              const Text(
                "Signup",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Flexible(
                    child: TextFormField(
                      controller: firstNameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "field required";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text("First name")),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.05,
                  ),
                  Flexible(
                    child: TextFormField(
                      controller: lastNameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "field required";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text("Last name")),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: emailController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "field required";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), label: Text("Email")),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "field required";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), label: Text("Passowrd")),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                obscureText: true,
                controller: confirmPassswordController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "field required";
                  } else if (value != passwordController.text) {
                    return "Password donot match";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("Confirm Password")),
              ),
              const SizedBox(
                height: 10,
              ),
              Obx(
                () => ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      controller.signUp(
                          firstNameController.text,
                          lastNameController.text,
                          emailController.text,
                          passwordController.text);
                    }
                  },
                  child: controller.isSignUpLoading.value
                      ? const CircularProgressIndicator()
                      : const Text("Signup"),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already a Artist? "),
                  GestureDetector(
                    onTap: () {
                      Get.to(const Login());
                    },
                    child: const Text(
                      "login",
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
    ));
  }
}
