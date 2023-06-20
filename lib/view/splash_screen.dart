import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:nepalihiphub/controller/splash_screen_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Get.put(SplashScreenController());
    return Scaffold(
      body: Column(
        children: [
          const Spacer(),
          Center(
            child: Image.asset(
              "assets/images/logo.png",
              height: 150,
            ),
          ),
          const Spacer(),
          const CircularProgressIndicator(),
          const Spacer()
        ],
      ),
    );
  }
}
