import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';
import 'package:nepalihiphub/controller/auth_controller.dart';
import 'package:nepalihiphub/view/profile/auth_page.dart';
import 'package:nepalihiphub/view/profile/profile_page.dart';

class MainProfilePage extends StatelessWidget {
  const MainProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthController());
    return Obx(() {
      if (controller.isLoggedIn.value) {
        return const ProfilePage();
      } else {
        return const Authpage();
      }
    });
  }
}
