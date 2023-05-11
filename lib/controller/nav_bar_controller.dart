import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:nepalihiphub/view/beats_page/beats_page.dart';
import 'package:nepalihiphub/view/home_page.dart';
import 'package:nepalihiphub/view/profile/profile_navigator.dart';

class NavBarController extends GetxController {
  RxInt selectedIndex = 0.obs;
  final audioPlayer = AudioPlayer();
  RxBool isCurrentlyPlaying = false.obs;
  String imageURL = "";
  String label = "";
  String beatURL = "";
  RxBool isPlaying = false.obs;
  Rx<Duration> duration = Duration.zero.obs;
  Rx<Duration> position = Duration.zero.obs;

  @override
  void dispose() {
    super.dispose();
    audioPlayer.dispose();
  }

  void changeDuration(Duration d) {
    duration.value = d;
    update();
  }

  void changePostion(Duration d) {
    position.value = d;
    update();
  }

  void changeMusic(
      {required String imageUrl,
      required String name,
      required String beatUrl}) {
    isCurrentlyPlaying.value = false;

    imageURL = imageUrl;
    label = name;
    beatURL = beatUrl;
    isCurrentlyPlaying.value = true;
    isPlaying.value = true;
    audioPlayer.play(UrlSource(beatUrl));
    update();
  }

  List<Widget> pages = const [Homepage(), BeatPage(), ProfileNavigator()];
}
