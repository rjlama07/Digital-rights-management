import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:nepalihiphub/view/beats_page/beats_page.dart';
import 'package:nepalihiphub/view/home_page.dart';
import 'package:nepalihiphub/view/profile/profile_navigator.dart';

class NavBarController extends GetxController {
  RxInt selectedIndex = 0.obs;

  RxBool isCurrentlyPlaying = false.obs;
  String imageUrl = "";
  String name = "";
  String beatUrl = "";

  void changeMusic(
      {required String imageUrl,
      required String name,
      required String beatUrl}) {
    isCurrentlyPlaying.value = false;
    this.imageUrl = imageUrl;
    this.name = name;
    this.beatUrl = beatUrl;
    isCurrentlyPlaying.value = true;
    update();
  }

  List<Widget> pages = const [Homepage(), BeatPage(), ProfileNavigator()];
}
