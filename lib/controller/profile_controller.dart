import 'package:dio/dio.dart';
import 'package:get/get.dart';

import 'package:hive_flutter/adapters.dart';
import 'package:nepalihiphub/constant/api.dart';
import 'package:nepalihiphub/model/user.dart';

class ProfileController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getUser();
  }

  RxBool isLoading = false.obs;
  User? user;
  Box box = Hive.box("localData");

  Future<void> getUser() async {
    try {
      String accessToken = box.get("accessToken");
      isLoading.value = true;
      final response = await Dio().get(getUserProfile,
          options: Options(headers: {"authorization": "bearer $accessToken"}));

      user = User.fromJson(response.data);

      isLoading.value = false;
    } on DioException catch (e) {}
  }
}
