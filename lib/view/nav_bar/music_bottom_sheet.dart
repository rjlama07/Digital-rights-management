import 'package:flutter/material.dart';

class MusicBottomSheet extends StatelessWidget {
  const MusicBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            color: Colors.grey,
            height: 10,
            width: 20,
          )
        ],
      ),
    );
  }
}
