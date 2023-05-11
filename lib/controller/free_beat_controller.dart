import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hive_flutter/adapters.dart';
import 'package:nepalihiphub/constant/api.dart';
import 'package:nepalihiphub/model/beat_model.dart';
import 'package:nepalihiphub/services/beats_services.dart';

class FreeBeatController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getFreebeat();
  }

  Box box = Hive.box("localData");

  RxString downlaodState = "Download now".obs;
  Future<void> addToFavourite({required String id, required int index}) async {
    try {
      String accessToken = box.get("accessToken");
      final headers = {
        'Content-Type': 'application/json;charset=UTF-8',
        'Charset': 'utf-8',
        'authorization': 'Bearer $accessToken'
      };

      await Dio().post(addtoFavouriteUrl,
          data: {"productId": id}, options: Options(headers: headers));
      freeBeats[index].isFav = true;
      update();
    } catch (e) {
      freeBeats[index].isFav = false;
      debugPrint(e.toString());
      Get.showSnackbar(const GetSnackBar(
        title: "Oops",
        titleText: Text("Failed to add to favourite"),
      ));
    }
  }

  RxBool isLoading = false.obs;
  RxList<BeatModel> freeBeats = RxList.empty();
  Future<void> getFreebeat() async {
    isLoading.value = true;
    final response = await BeatServices().getFreeBeats(getBeat);
    response.fold(
        (l) => {
              freeBeats.value = l,
            },
        (r) => {debugPrint(r)});
    isLoading.value = false;
  }
}
