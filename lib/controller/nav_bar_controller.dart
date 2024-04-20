import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:nepalihiphub/view/beats_page/user_library_page.dart';
import 'package:nepalihiphub/view/home_page/home_navigator.dart';
import 'package:nepalihiphub/view/profile/profile_page.dart';

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
    AudioSource audioSource = AudioSource.uri(
      Uri.parse(beatUrl),
      tag: MediaItem(
        id: beatUrl,
        album: name,
        title: name,
        artUri: Uri.parse(imageUrl),
      ),
    );
    audioPlayer.setAudioSource(audioSource);
    audioPlayer.play();
    audioPlayer.play();
    update();
  }

  List<Widget> pages = const [
    HomeNavigator(),
    UserLibraryPage(),
    ProfilePage()
  ];
}
