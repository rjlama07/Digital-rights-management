import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:nepalihiphub/constant/api.dart';
import 'package:nepalihiphub/services/beats_services.dart';
import 'package:nepalihiphub/view/album/screens/album_screens.dart';
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
  RxBool isPlayList = false.obs;

  final dio = Dio();

  @override
  void dispose() {
    super.dispose();
    audioPlayer.dispose();
  }

  Future<void> addStreamCount(String songId) async {
    try {
      dio.put(addStreamCountUrl, data: {"songId": songId});
      debugPrint("-------------Song Count Added---------------");
    } on DioException catch (e) {
      debugPrint("----------------Song Count Error-----------------");
      debugPrint(e.toString());
    } catch (e) {
      debugPrint("----------------Song Count Error-----------------");
      debugPrint(e.toString());
    }
  }

  Future<void> addLikeSong(
      {required String beatId, required Function onSucesss}) async {
    final response = await BeatServices().addLikedSong(beatId);
    response.fold((l) {
      Get.snackbar("Success", "Song added to liked list");
    }, (r) {
      Get.snackbar("Error", r);
    });
  }

  void playSingleSong({
    required String imageUrl,
    required String name,
    required String beatId,
    required String beatUrl,
  }) {
    isCurrentlyPlaying.value = false;
    isPlayList.value = false;

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
    addStreamCount(beatId);
    update();
  }

  void playPlaylist({
    required List<String> imageUrls,
    required List<String> names,
    required List<String> beatIds,
    required List<String> beatUrls,
  }) {
    isPlayList.value = false;
    isCurrentlyPlaying.value = false;
    final playList = ConcatenatingAudioSource(
      children: List.generate(
        beatUrls.length,
        (index) => AudioSource.uri(
          Uri.parse(beatUrls[index]),
          tag: MediaItem(
            id: beatIds[index],
            album: names[index],
            title: names[index],
            artUri: Uri.parse(imageUrls[index]),
          ),
        ),
      ),
    );
    audioPlayer.setLoopMode(LoopMode.all);
    audioPlayer.setAudioSource(playList);

    isCurrentlyPlaying.value = true;
    isPlaying.value = true;
    audioPlayer.play();
    update();
  }

  List<Widget> pages = const [
    HomeNavigator(),
    UserLibraryPage(),
    AlbumScreens(),
    ProfilePage(),
  ];
}
