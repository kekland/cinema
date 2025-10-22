import 'package:cinema/cinema.dart';
import 'package:flutter/material.dart';

class VideoPlayerWidget extends StatelessWidget {
  const VideoPlayerWidget({super.key, required this.player});

  final VideoPlayer player;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.0,
      child: player.buildWidget(),
    );
  }
}
