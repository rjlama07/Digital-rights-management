import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hive_flutter/adapters.dart';
import 'package:nepalihiphub/services/auth_service.dart';
import 'package:nepalihiphub/view/home_page.dart';
import 'package:nepalihiphub/view/login/login.dart';
import 'package:nepalihiphub/view/nav_bar/nav_bar.dart';

class AuthController extends GetxController {
  Box box = Hive.box('localData');
  RxBool isSignUpLoading = false.obs;
  RxBool isLoginLoading = false.obs;

  void signUp(
      String firstName, String lastName, String email, String password) async {
    isSignUpLoading.value = true;
    final response =
        await AuthServices().sigup(firstName, lastName, email, password);
    isSignUpLoading.value = false;
    response.fold(
        (l) => {
              Get.to(const Login()),
            },
        (r) => {Get.snackbar("", r, backgroundColor: Colors.red)});
  }

  void login(String email, String password) async {
    isLoginLoading.value = true;
    final response = await AuthServices().login(email, password);
    isLoginLoading.value = false;
    response.fold(
        (l) => {
              box.put("isLoggedin", true),
              Get.to(const NavBar()),
            },
        (r) => {Get.snackbar("", r, backgroundColor: Colors.red)});
  }
}
