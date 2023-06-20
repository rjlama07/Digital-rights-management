import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:nepalihiphub/model/beat_model.dart';
import 'package:nepalihiphub/services/beats_services.dart';

class PaidBeatController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getFreebeat();
  }

  RxBool isLoading = false.obs;
  RxList<PaidBeatModel> paidBeats = RxList.empty();
  Future<void> getFreebeat() async {
    isLoading.value = true;
    final response = await BeatServices().getPaidBeats();
    response.fold(
        (l) => {
              paidBeats.value = l,
            },
        (r) => {debugPrint(r)});
    isLoading.value = false;
  }
}
