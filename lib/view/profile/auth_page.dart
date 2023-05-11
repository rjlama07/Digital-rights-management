import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:nepalihiphub/controller/auth_controller.dart';
import 'package:nepalihiphub/controller/profile_controller.dart';
import 'package:nepalihiphub/widget/custom_button.dart';

class Authpage extends StatelessWidget {
  const Authpage({super.key});
  static final emailController = TextEditingController();
  static final passwordController = TextEditingController();
  static final sEmailController = TextEditingController();
  static final sPasswordController = TextEditingController();
  static final firstnameController = TextEditingController();
  static final lastnameController = TextEditingController();
  static final sConfirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Widget loginWidget() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Login", style: Theme.of(context).textTheme.titleLarge),
          SizedBox(height: MediaQuery.of(context).size.height * 0.04),
          TextFormField(
            controller: emailController,
            decoration: const InputDecoration(
              hintText: "Email",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              focusedBorder:
                  OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
              border: OutlineInputBorder(),
              hintText: "Password",
            ),
          )
        ],
      );
    }

    Widget signup() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Register", style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 20),
          Row(
            children: [
              Flexible(
                child: TextFormField(
                  controller: firstnameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "field required";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: "first name"),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.05,
              ),
              Flexible(
                child: TextFormField(
                  controller: lastnameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "field required";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: "last name"),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: sEmailController,
            validator: (value) {
              if (value!.isEmpty) {
                return "field required";
              }
              return null;
            },
            decoration: const InputDecoration(
                border: OutlineInputBorder(), hintText: "email"),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: sPasswordController,
            obscureText: true,
            validator: (value) {
              if (value!.isEmpty) {
                return "field required";
              }
              return null;
            },
            decoration: const InputDecoration(
                border: OutlineInputBorder(), hintText: "passowrd"),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            obscureText: true,
            controller: sConfirmPasswordController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value!.isEmpty) {
                return "field required";
              } else if (value != sPasswordController.text) {
                return "Password donot match";
              }
              return null;
            },
            decoration: const InputDecoration(
                border: OutlineInputBorder(), hintText: " confirm passowrd"),
          ),
        ],
      );
    }

    final controller = Get.find<AuthController>();
    return SafeArea(
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Center(
                child: Image.asset(
                  "assets/images/account.png",
                  height: 150,
                  fit: BoxFit.fill,
                ),
              ),
              Obx(() => controller.isSignup.value ? signup() : loginWidget()),
              const SizedBox(height: 20),
              Obx(() => CustomButtom(
                    isLoading: controller.isSignup.value
                        ? controller.isSignUpLoading.value
                        : controller.isLoginLoading.value,
                    text: !controller.isSignup.value ? "Login" : "Signup",
                    ontap: () async {
                      if (controller.isSignup.value) {
                        controller.signUp(
                            firstnameController.text,
                            lastnameController.text,
                            sEmailController.text,
                            sPasswordController.text, () {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("User signup sucessfully")));
                        });
                      } else {
                        await controller.login(
                            emailController.text, passwordController.text);

                        Get.put(ProfileController()).getUser();
                      }
                    },
                  )),
              SizedBox(height: MediaQuery.of(context).size.height * 0.04),
              Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          controller.isSignup.value
                              ? "Alredy a user? "
                              : "Don't have a account? ",
                          style: Theme.of(context).textTheme.labelMedium!),
                      InkWell(
                        onTap: () {
                          controller.isSignup.value =
                              !controller.isSignup.value;
                        },
                        child: Text(
                            controller.isSignup.value ? "Login" : "Signup",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(color: Colors.blue)),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      )),
    );
  }
}
