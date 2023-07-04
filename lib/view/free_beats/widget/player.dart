import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class PlayerAudio extends StatefulWidget {
  const PlayerAudio({Key? key, required this.beatUrl}) : super(key: key);

  final String beatUrl;

  @override
  State<PlayerAudio> createState() => _PlayerAudioState();
}

class _PlayerAudioState extends State<PlayerAudio> {
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
    return Column(
      children: [
        Slider(
          max: duration.inSeconds.toDouble(),
          value: position.inSeconds.toDouble(),
          onChanged: (value) async {
            final position = Duration(seconds: value.toInt());
            await audioPlayer.seek(position);
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(formatTime(position)),
              Text(formatTime(duration - position)),
            ],
          ),
        ),
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
          child: Center(
            child: CircleAvatar(
              radius: 20,
              child: Icon(
                isPlaying ? Icons.pause : Icons.play_arrow,
                size: 18,
              ),
            ),
          ),
        )
      ],
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
