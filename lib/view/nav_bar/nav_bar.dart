import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                  name: controller.name,
                  imageUrl: controller.imageUrl,
                  beatUrl: controller.beatUrl),
            )),
      body: Obx(() => IndexedStack(
          index: controller.selectedIndex.value, children: controller.pages)),
      bottomNavigationBar: Container(
          color: Colors.black,
          padding: const EdgeInsets.only(bottom: 10),
          child: Obx(
            () => BottomNavigationBar(
                currentIndex: controller.selectedIndex.value,
                onTap: (value) {
                  controller.selectedIndex.value = value;
                },
                selectedItemColor: Colors.red,
                unselectedItemColor: Colors.grey.withOpacity(0.4),
                backgroundColor: secondaryBackgroundColor,
                items: const [
                  BottomNavigationBarItem(
                      label: "Home", icon: Icon(Icons.home)),
                  BottomNavigationBarItem(
                      label: "Beats", icon: Icon(Icons.music_note)),
                  BottomNavigationBarItem(
                      label: "Profile",
                      icon: Icon(Icons.account_circle_rounded)),
                ]),
          )),
    );
  }
}

class CustomPlayer extends StatefulWidget {
  final String name;
  final String imageUrl;
  const CustomPlayer(
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
  final audioPlayer = AudioPlayer();
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  bool isPlaying = false;
  bool disposed = false;

  @override
  void initState() {
    super.initState();

    audioPlayer.onPlayerStateChanged.listen((event) {
      if (!disposed) {
        setState(() {
          isPlaying = event == PlayerState.playing;
        });
      }
    });

    audioPlayer.onDurationChanged.listen((event) {
      if (!disposed) {
        setState(() {
          duration = event;
        });
      }
    });

    audioPlayer.onPositionChanged.listen((event) {
      if (!disposed) {
        setState(() {
          position = event;
        });
      }
    });

    // _initAudioPlayer();
  }

  // void _initAudioPlayer() async {
  //   await audioPlayer.play(UrlSource(widget.beatUrl));
  // }

  @override
  void dispose() {
    disposed = true;
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      child: InkWell(
        onTap: () {
          showModalBottomSheet(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return const MusicBottomSheet();
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
                if (isPlaying) {
                  audioPlayer.pause();
                  isPlaying = false;
                } else {
                  await audioPlayer.play(UrlSource(widget.beatUrl));
                  isPlaying = true;
                }
                if (!disposed) {
                  setState(() {});
                }
              },
              child: Icon(
                isPlaying ? Icons.pause : Icons.play_arrow,
                size: 26,
              ),
            ),
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
