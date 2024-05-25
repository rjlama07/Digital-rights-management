import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:nepalihiphub/controller/nav_bar_controller.dart';
import 'package:nepalihiphub/view/home_page/home_navigator.dart';
import 'package:nepalihiphub/view/nav_bar/music_bottom_sheet.dart';
import 'package:nepalihiphub/view/nav_bar/widgets/controls.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavBarController());

    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomSheet: Obx(() => !controller.isCurrentlyPlaying.value
          ? const SizedBox()
          : SizedBox(
              height: 60,
              child: StreamBuilder<SequenceState?>(
                stream: controller.audioPlayer.sequenceStateStream,
                builder: (context, snapshot) {
                  final state = snapshot.data;
                  final metaData = state!.currentSource!.tag as MediaItem;
                  return CustomPlayer(
                      name: metaData.title,
                      imageUrl: metaData.artUri.toString(),
                      beatUrl: controller.beatURL);
                },
              ),
            )),
      body: Obx(() => IndexedStack(
          index: controller.selectedIndex.value, children: controller.pages)),
      bottomNavigationBar: Container(
        color: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),

        // )
        child: GNav(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            duration:
                const Duration(milliseconds: 100), // tab animation duration
            gap: 8, // the tab button gap between icon and text
            color: Colors.grey[800], // unselected icon color
            activeColor: Colors.red, // selected icon and text color
            iconSize: 24, // tab button icon size
            tabBackgroundColor: Colors.white,
            tabs: const [
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                icon: Icons.music_note,
                text: 'Beats',
              ),
              GButton(
                icon: Icons.account_circle_rounded,
                text: 'Profile',
              ),
            ],
            selectedIndex: controller.selectedIndex.value,
            onTabChange: (index) {
              controller.selectedIndex.value = index;

              if (index == 0) {
                homeNavKey.currentState!.pushReplacementNamed(
                    '/'); // If the "Home" tab is selected, navigate to the home page
              }
            }),
      ),
    );
  }
}

class CustomPlayer extends StatefulWidget {
  final String name;
  final String imageUrl;
  final controller = Get.find<NavBarController>();
  CustomPlayer(
      {Key? key,
      required this.beatUrl,
      required this.imageUrl,
      required this.name})
      : super(key: key);

  final String beatUrl;

  @override
  State<CustomPlayer> createState() => _CustomPlayerState();
}

class _CustomPlayerState extends State<CustomPlayer> {
  bool disposed = false;

  @override
  void initState() {
    super.initState();

    // widget.controller.audioPlayer.onPlayerStateChanged.listen((event) {
    //   widget.controller.isPlaying.value = event == PlayerState.playing;
    // });

    // widget.controller.audioPlayer.onDurationChanged.listen((event) {
    //   widget.controller.changeDuration(event);
    // });

    // widget.controller.audioPlayer.onPositionChanged.listen((event) {
    //   widget.controller.changePostion(event);
    // });

    // _initAudioPlayer();
  }

  // void _initAudioPlayer() async {
  //   await audioPlayer.play(UrlSource(widget.beatUrl));
  // }

  @override
  void dispose() {
    // disposed = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                backgroundColor: Colors.transparent,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return StreamBuilder<SequenceState?>(
                    stream: Get.find<NavBarController>()
                        .audioPlayer
                        .sequenceStateStream,
                    builder: (context, snapshot) {
                      final metaDta =
                          snapshot.data?.currentSource?.tag as MediaItem;
                      return MusicBottomSheet(
                        imageUrl: metaDta.artUri.toString(),
                        beatUrl: widget.beatUrl,
                        name: metaDta.title ?? "",
                      );
                    },
                  );
                },
              );
            },
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(widget.imageUrl))),
                  height: 80,
                  width: 60,
                ),
                const SizedBox(width: 10),
                Text(widget.name),
                const Spacer(),
                // InkWell(
                //     onTap: () async {
                //       if (widget.controller.isPlaying.value) {
                //         widget.controller.audioPlayer.pause();
                //         widget.controller.isPlaying.value = false;
                //       } else {
                //         await widget.controller.audioPlayer
                //             .play();
                //         widget.controller.isPlaying.value = true;
                //       }
                //     },
                //     child: Obx(
                //       () => Icon(
                //         widget.controller.isPlaying.value
                //             ? Icons.pause
                //             : Icons.play_arrow,
                //         size: 26,
                //       ),
                //     )),
                Control(
                  audioPlayer: widget.controller.audioPlayer,
                  isPlaylist: Get.find<NavBarController>().isPlayList.value,
                ),

                const SizedBox(width: 10),
              ],
            ),
          ),
        ));
  }
}

String formatTime(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  final hours = twoDigits(duration.inHours);
  final minutes = twoDigits(duration.inMinutes.remainder(60));
  final seconds = twoDigits(duration.inSeconds.remainder(60));

  return [if (duration.inHours > 0) hours, minutes, seconds].join(":");
}
