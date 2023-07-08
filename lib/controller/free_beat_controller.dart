import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:nepalihiphub/model/beat_model.dart';
import 'package:nepalihiphub/services/beats_services.dart';

class FreeBeatController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getFreebeat();
  }

  RxString downlaodState = "Download now".obs;

  RxBool isLoading = false.obs;
  RxList<BeatModel> freeBeats = RxList.empty();
  Future<void> getFreebeat() async {
    isLoading.value = true;
    final response = await BeatServices().getFreeBeats();
    response.fold(
        (l) => {
              freeBeats.value = l,
            },
        (r) => {debugPrint(r)});
    isLoading.value = false;
  }
}
