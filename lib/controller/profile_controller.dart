import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nepalihiphub/constant/api.dart';
import 'package:nepalihiphub/model/user.dart';
import 'package:dio/dio.dart' as dio;
import 'package:nepalihiphub/services/auth_service.dart';

class ProfileController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getUser();
  }

  RxBool isLoading = false.obs;
  RxBool isImageUploading = false.obs;
  RxBool isPasswordChanging = false.obs;

  Box box = Hive.box("localData");

  Rx<User?> user = User(
          imageUrl: "",
          firstName: "firstName",
          email: "email",
          lastName: "lastName")
      .obs;

  Future<void> changePassword(
      String oldPassword, String newPassword, Function onSucess) async {
    isPasswordChanging.value = true;
    final response =
        await AuthServices().changePassword(oldPassword, newPassword);
    response.fold((l) {
      Get.snackbar("Sucessfully", "password changed successfully",
          colorText: Colors.white, backgroundColor: Colors.green);
      onSucess();
    }, (r) {
      Get.snackbar("error", r,
          colorText: Colors.white, backgroundColor: Colors.red);
    });
  }

  Future<void> changeProfileImage(ImageSource imageSource) async {
    isImageUploading.value = true;
    String accessToken = box.get("accessToken");

    final image = await ImagePicker().pickImage(source: imageSource);
    if (image != null) {
      List<int> bytes = await image.readAsBytes();
      String fileName = image.name;

      dio.FormData formData = dio.FormData.fromMap({
        'image': dio.MultipartFile.fromBytes(bytes, filename: fileName),
      });

      try {
        final headers = {
          'Content-Type': 'application/json;charset=UTF-8',
          'Charset': 'utf-8',
          'authorization': 'Bearer $accessToken'
        };
        Dio dio = Dio();
        final response = await dio.post(uploadProfileImage,
            data: formData, options: Options(headers: headers));
        final imageUrl = (response.data)["imageUrl"];
        user.value!.imageUrl = imageUrl;
        isImageUploading.value = false;
      } on DioException catch (error) {
        isImageUploading.value = false;
        print(error.response!.data);
      }
    } else {
      isImageUploading.value = false;
    }
  }

  Future<void> getUser() async {
    try {
      String accessToken = box.get("accessToken") ?? "";
      isLoading.value = true;
      final response = await Dio().get(getUserProfile,
          options: Options(headers: {"authorization": "bearer $accessToken"}));

      user.value = User.fromJson(response.data);

      isLoading.value = false;
    } on DioException catch (e) {}
  }
}
