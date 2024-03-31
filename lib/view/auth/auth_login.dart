import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:nepalihiphub/constant/text.dart';
import 'package:nepalihiphub/controller/auth_controller.dart';
import 'package:nepalihiphub/view/auth/login/login_page.dart';
import 'package:nepalihiphub/view/auth/signup/auth_signup.dart';

class AuthPageMain extends StatelessWidget {
  const AuthPageMain({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthController());
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Column(
              children: [
                const Spacer(),
                Image.asset("assets/images/logo_1.png"),
                const Spacer(),
                Text(
                  "Revolutionizing\nNepali Music Industry",
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .copyWith(fontSize: 28),
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
                ElevatedButton(
                    onPressed: () {
                      Get.to(const MainSignupPage());
                    },
                    child: const Center(child: Text("Sign Up for free"))),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 20),
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.white, width: 1),
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    onPressed: () => controller.googleSignWithGoogle(),
                    child: Row(
                      children: [
                        Image.asset("assets/images/google.png"),
                        const Spacer(),
                        const Text("Continue with Google"),
                        const Spacer(),
                      ],
                    )),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 20),
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.white, width: 1),
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    onPressed: () {},
                    child: Row(
                      children: [
                        Image.asset("assets/images/apple.png"),
                        const Spacer(),
                        const Text("Continue with Apple"),
                        const Spacer(),
                      ],
                    )),
                const SizedBox(height: 20),
                InkWell(
                    onTap: () {
                      Get.to(const MainLoginPage());
                    },
                    child: Text("Login", style: darkTextTheme.bodyMedium)),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
