import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';

class HomepageContoller extends GetxController {
  RxBool isAlreadyLiked = false.obs;
  RxInt totalLikes = 0.obs;

  void addLike() {
    if (!isAlreadyLiked.value) {
      totalLikes.value++;
      Get.snackbar("Congratulation", "Reaction added sucessfully");
      isAlreadyLiked.value = true;
    } else {
      Get.snackbar("Oops", "You have already reacted",
          backgroundColor: Colors.red);
    }
  }
}
