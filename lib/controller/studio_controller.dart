import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:nepalihiphub/model/studio_model.dart';
import 'package:nepalihiphub/services/studio_services.dart';

class StudioController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getStudio();
  }

  RxBool isLoading = false.obs;
  RxList<StudioModel> studio = RxList.empty();

  Future<void> getStudio() async {
    isLoading.value = true;
    final response = await StudioService().getStudioModel();
    response.fold(
        (l) => {
              studio.value = l,
            },
        (r) => {});
    isLoading.value = false;
  }
}
