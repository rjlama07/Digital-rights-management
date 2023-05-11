import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';
import 'package:nepalihiphub/constant/app_colors.dart';
import 'package:nepalihiphub/controller/nav_bar_controller.dart';

class MusicBottomSheet extends StatefulWidget {
  const MusicBottomSheet(
      {super.key,
      required this.imageUrl,
      required this.beatUrl,
      required this.name});
  final String imageUrl;
  final String beatUrl;
  final String name;

  @override
  State<MusicBottomSheet> createState() => _MusicBottomSheetState();
}

class _MusicBottomSheetState extends State<MusicBottomSheet>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool disposed = false;
  final controller = Get.find<NavBarController>();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 12),
      vsync: this,
    )..repeat();

    controller.audioPlayer.onPlayerStateChanged.listen((event) {
      controller.isPlaying.value = event == PlayerState.playing;
    });

    controller.audioPlayer.onDurationChanged.listen((event) {
      controller.changeDuration(event);
    });

    controller.audioPlayer.onPositionChanged.listen((event) {
      controller.changePostion(event);
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NavBarController>();

    final curvedAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.linear,
    );
    return DraggableScrollableSheet(
      initialChildSize: 0.92,
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: const BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(20)),
                height: 6,
                width: 80,
              ),
              const SizedBox(height: 40),
              RotationTransition(
                  turns: Tween(begin: 0.0, end: 1.0).animate(curvedAnimation),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 2.0,
                          ),
                        ),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(widget.imageUrl),
                          radius: MediaQuery.of(context).size.height * 0.18,
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: backgroundColor,
                        foregroundColor: backgroundColor,
                        radius: MediaQuery.of(context).size.height * 0.05,
                      ),
                    ],
                  )),
              SizedBox(height: 50.h),
              Text(
                widget.name,
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(color: Colors.white),
              ),
              SizedBox(height: 30.h),
              Obx(
                () => Slider(
                  activeColor: Colors.red,
                  max: controller.duration.value.inSeconds.toDouble(),
                  value: controller.position.value.inSeconds.toDouble(),
                  onChanged: (value) async {
                    final position = Duration(seconds: value.toInt());
                    await controller.audioPlayer.seek(position);
                  },
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(formatTime(controller.position.value)),
                        Text(formatTime(controller.duration.value)),
                      ],
                    ),
                  )),
              SizedBox(height: 30.h),
              InkWell(
                onTap: () async {
                  if (controller.isPlaying.value) {
                    controller.audioPlayer.pause();

                    controller.isPlaying.value = false;
                  } else {
                    await controller.audioPlayer
                        .play(UrlSource(widget.beatUrl));
                    controller.isPlaying.value = true;
                  }
                },
                child: Center(
                  child: Obx(
                    () => Icon(
                      controller.isPlaying.value
                          ? Icons.pause
                          : Icons.play_arrow,
                      size: 30.h,
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
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
