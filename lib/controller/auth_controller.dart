import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hive_flutter/adapters.dart';
import 'package:nepalihiphub/services/auth_service.dart';

class AuthController extends GetxController {
  Box box = Hive.box('localData');
  RxBool isLoggedIn = false.obs;
  RxBool isSignup = false.obs;
  RxBool isSignUpLoading = false.obs;
  RxBool isLoginLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkAuthState();
  }

  void checkAuthState() {
    bool checkLoginIn = box.get("isLoggedIn") ?? false;
    isLoggedIn.value = checkLoginIn;
  }

  void signUp(String firstName, String lastName, String email, String password,
      Function onsucess) async {
    isSignUpLoading.value = true;
    final response =
        await AuthServices().sigup(firstName, lastName, email, password);
    isSignUpLoading.value = false;
    response.fold(
        (l) => {
              isSignup.value = false,
              onsucess(),
            },
        (r) => {Get.snackbar("", r, backgroundColor: Colors.red)});
  }

  Future<void> login(String email, String password) async {
    isLoginLoading.value = true;
    final response = await AuthServices().login(email, password);
    isLoginLoading.value = false;
    response.fold(
        (l) => {
              box.put("isLoggedIn", true),
              isLoggedIn.value = true,
            },
        (r) => {Get.snackbar("", r, backgroundColor: Colors.red)});
  }

  void logOut() {
    box.delete("accessToken");
    box.put("isLoggedIn", false);
    isLoggedIn.value = false;
  }
}
