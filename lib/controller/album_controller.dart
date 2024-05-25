import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:nepalihiphub/model/album_model.dart';
import 'package:nepalihiphub/services/album_services.dart';
import 'package:nepalihiphub/view/album/screens/album_screens.dart';

class AlbumControllr extends GetxController {
  RxBool isLoading = false.obs;
  String errorMessage = "";
  RxList<AlbumModel> albumList = <AlbumModel>[].obs;
  RxBool isError = false.obs;
  RxList<AlbumModel> filterList = <AlbumModel>[].obs;

  void filterAlbum(Filter filter) {
    //switch case for filter
    switch (filter) {
      case Filter.all:
        filterList.assignAll(albumList);
        break;
      case Filter.free:
        filterList.assignAll(
            albumList.where((element) => element.type == "free").toList());
        break;
      case Filter.paid:
        filterList.assignAll(
            albumList.where((element) => element.type == "paid").toList());
        break;

      case Filter.myPurchased:
        filterList.assignAll(
            albumList.where((element) => element.isBought == true).toList());
        break;
    }
  }

  @override
  void onInit() async {
    await getAlbum();
    filterList.assignAll(albumList);
    super.onInit();
  }

  Future<void> getAlbum() async {
    print("hbashndfbashjbdhjasbdhjasbdhjasbdhjabsdhj");
    isLoading.value = true;
    final response = await AlbumSercies().getAlbums();
    response.fold((albums) {
      albumList.assignAll(albums);
    }, (error) {
      isError.value = true;
      errorMessage = error;
    });
    isLoading.value = false;
  }
}
