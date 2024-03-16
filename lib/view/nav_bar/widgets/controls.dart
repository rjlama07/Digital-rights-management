import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class Control extends StatelessWidget {
  const Control({super.key, required this.audioPlayer,this.iconsize=26});
  final AudioPlayer audioPlayer;
  final double iconsize;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PlayerState>(
      stream: audioPlayer.playerStateStream,
      builder: (context, snapshot) {
        final playerState = snapshot.data;
        final processingState = playerState?.processingState;
        final playing = playerState?.playing;
        if (!(playing ?? false)) {
          return IconButton(
            icon: const Icon(Icons.play_arrow),
            iconSize: iconsize,
            onPressed: audioPlayer.play,
          );
        }
        else if(processingState != ProcessingState.completed){
          return IconButton(
            icon: const Icon(Icons.pause),
            iconSize: iconsize,
            onPressed: audioPlayer.pause,
          );
        }
        return const Icon(Icons.abc);
        
      },
    );
  }
}
