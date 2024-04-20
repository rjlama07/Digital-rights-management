import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:nepalihiphub/controller/auth_controller.dart';

class MainSignupPage extends StatefulWidget {
  const MainSignupPage({super.key});

  @override
  State<MainSignupPage> createState() => _MainSignupPageState();
}

class _MainSignupPageState extends State<MainSignupPage> {
  late TextEditingController nameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    nameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authController = Get.put(AuthController());
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

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () => Get.back(),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.black),
                              color: Colors.black),
                          child:
                              const Center(child: Icon(Icons.arrow_back_ios)),
                        ),
                      ),
                      const Spacer(),
                      Text("Create Account",
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(fontSize: 20)),
                      const Spacer(),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  buildTextField(
                    controller: nameController,
                    hintText: "Whats your firstName?",
                  ),
                  const SizedBox(height: 20),
                  buildTextField(
                    controller: lastNameController,
                    hintText: "Whats your lastName?",
                  ),
                  const SizedBox(height: 20),
                  buildTextField(
                    controller: emailController,
                    hintText: "Whats your email address?",
                  ),
                  const SizedBox(height: 20),
                  buildTextField(
                    controller: passwordController,
                    isObsecure: true,
                    hintText: "Create Password",
                  ),
                  const SizedBox(height: 20),
                  buildTextField(
                    controller: confirmPasswordController,
                    isObsecure: true,
                    hintText: "Confirm Password",
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        authController.signUp(
                          nameController.text,
                          lastNameController.text,
                          emailController.text,
                          passwordController.text,
                          () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("User signup sucessfully"),
                              ),
                            );
                            Get.back();
                          },
                        );
                      }
                    },
                    child: const Center(child: Text("Sign Up")),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
