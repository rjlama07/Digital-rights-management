import 'package:get/get.dart';

class FolowArtistInitialController extends GetxController {
  RxList<String> selecttedArtist = RxList.empty();

  void addArtist(String artist) {
    if (selecttedArtist.contains(artist)) {
      selecttedArtist.remove(artist);
    } else {
      selecttedArtist.add(artist);
    }
    update();
  }
}
