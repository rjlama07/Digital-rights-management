import 'package:get/get.dart';

import 'package:nepalihiphub/model/beat_model.dart';
import 'package:nepalihiphub/services/beats_services.dart';

class SearchBeatController extends GetxController {
  BeatServices beatServices = BeatServices();
  RxList<BeatModel> beatModel = RxList.empty();
  RxBool isLoading = false.obs;
  RxBool haveSearched = false.obs;

  Future<void> searchBeat(String queryParameter) async {
    haveSearched.value = true;
    isLoading.value = true;
    final response = await beatServices.searchBeat(queryParameter);
    isLoading.value = false;
    response.fold((l) {
      beatModel.assignAll(l);
    }, (r) {});
  }
}
