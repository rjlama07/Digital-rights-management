import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../constant/api.dart';
import '../model/beat_model.dart';
import '../services/beats_services.dart';

class FavouriteController extends GetxController {
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
    final response = await BeatServices().getFreeBeats(getFavouriteBeats);
    response.fold(
        (l) => {
              freeBeats.value = l,
            },
        (r) => {debugPrint(r)});
    isLoading.value = false;
  }
}
