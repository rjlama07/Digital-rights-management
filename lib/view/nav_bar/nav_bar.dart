import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:nepalihiphub/constant/app_colors.dart';
import 'package:nepalihiphub/controller/nav_bar_controller.dart';
import 'package:nepalihiphub/view/nav_bar/music_bottom_sheet.dart';

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
              child: CustomPlayer(
                  name: controller.label,
                  imageUrl: controller.imageURL,
                  beatUrl: controller.beatURL),
            )),
      body: Obx(() => IndexedStack(
          index: controller.selectedIndex.value, children: controller.pages)),
      bottomNavigationBar: Container(
        color: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        // child: Obx(
        //   () => BottomNavigationBar(
        //       currentIndex: controller.selectedIndex.value,
        //       onTap: (value) {
        //         controller.selectedIndex.value = value;
        //       },
        //       selectedItemColor: Colors.red,
        //       unselectedItemColor: Colors.grey.withOpacity(0.4),
        //       backgroundColor: secondaryBackgroundColor,
        //       items: const [
        //         BottomNavigationBarItem(
        //             label: "Home", icon: Icon(Icons.home)),
        //         BottomNavigationBarItem(
        //             label: "Beats", icon: Icon(Icons.music_note)),
        //         BottomNavigationBarItem(
        //             label: "Profile",
        //             icon: Icon(Icons.account_circle_rounded)),
        //       ]),
        // )
        child: GNav(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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

    widget.controller.audioPlayer.onPlayerStateChanged.listen((event) {
      widget.controller.isPlaying.value = event == PlayerState.playing;
    });

    widget.controller.audioPlayer.onDurationChanged.listen((event) {
      widget.controller.changeDuration(event);
    });

    widget.controller.audioPlayer.onPositionChanged.listen((event) {
      widget.controller.changePostion(event);
    });

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
    return Padding(
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
              return MusicBottomSheet(
                  imageUrl: widget.imageUrl,
                  beatUrl: widget.beatUrl,
                  name: widget.name);
            },
          );
        },
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                      fit: BoxFit.cover, image: NetworkImage(widget.imageUrl))),
              height: 80,
              width: 60,
            ),
            const SizedBox(width: 10),
            Text(widget.name),
            const Spacer(),
            InkWell(
                onTap: () async {
                  if (widget.controller.isPlaying.value) {
                    widget.controller.audioPlayer.pause();
                    widget.controller.isPlaying.value = false;
                  } else {
                    await widget.controller.audioPlayer
                        .play(UrlSource(widget.beatUrl));
                    widget.controller.isPlaying.value = true;
                  }
                },
                child: Obx(
                  () => Icon(
                    widget.controller.isPlaying.value
                        ? Icons.pause
                        : Icons.play_arrow,
                    size: 26,
                  ),
                )),
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}

String formatTime(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  final hours = twoDigits(duration.inHours);
  final minutes = twoDigits(duration.inMinutes.remainder(60));
  final seconds = twoDigits(duration.inSeconds.remainder(60));

  return [if (duration.inHours > 0) hours, minutes, seconds].join(":");
}
