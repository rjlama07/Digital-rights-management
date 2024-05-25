import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:just_audio/just_audio.dart';

class Control extends StatelessWidget {
  const Control(
      {super.key,
      required this.audioPlayer,
      this.iconsize = 26,
      required this.isPlaylist});
  final AudioPlayer audioPlayer;
  final double iconsize;
  final bool isPlaylist;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PlayerState>(
      stream: audioPlayer.playerStateStream,
      builder: (context, snapshot) {
        final playerState = snapshot.data;
        final processingState = playerState?.processingState;
        final playing = playerState?.playing;
        if (!(playing ?? false)) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Visibility(
                visible: true,
                child: IconButton(
                    onPressed: () {
                      audioPlayer.seekToPrevious();
                    },
                    icon: Icon(
                      Icons.skip_previous,
                      size: iconsize,
                    )),
              ),
              IconButton(
                icon: const Icon(Icons.play_arrow),
                iconSize: iconsize,
                onPressed: audioPlayer.play,
              ),
              Visibility(
                visible: true,
                child: IconButton(
                    onPressed: () {
                      audioPlayer.seekToNext();
                    },
                    icon: Icon(
                      Icons.skip_next,
                      size: iconsize,
                    )),
              ),
            ],
          );
        } else if (processingState != ProcessingState.completed) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Visibility(
                visible: true,
                child: IconButton(
                    onPressed: () {
                      audioPlayer.seekToPrevious();
                    },
                    icon: Icon(
                      Icons.skip_previous,
                      size: iconsize,
                    )),
              ),
              IconButton(
                icon: const Icon(Icons.pause),
                iconSize: iconsize,
                onPressed: audioPlayer.pause,
              ),
              Visibility(
                visible: true,
                child: IconButton(
                    onPressed: () {
                      audioPlayer.seekToNext();
                    },
                    icon: Icon(
                      Icons.skip_next,
                      size: iconsize,
                    )),
              ),
            ],
          );
        }
        return const Icon(Icons.abc);
      },
    );
  }
}
