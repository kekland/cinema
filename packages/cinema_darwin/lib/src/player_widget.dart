import 'dart:io';

import 'package:cinema_darwin/src/player.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class DarwinVideoPlayerWidget extends StatelessWidget {
  const DarwinVideoPlayerWidget({
    super.key,
    required this.player,
    required this.avPlayerPointer,
  });

  final DarwinVideoPlayerImplementation player;
  final int avPlayerPointer;

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return IOSVideoPlayerWidget(player: player, avPlayerPointer: avPlayerPointer);
    } else if (Platform.isMacOS) {
      return MacOSVideoPlayerWidget(player: player, avPlayerPointer: avPlayerPointer);
    } else {
      throw UnsupportedError('DarwinVideoPlayerWidget is only supported on iOS and macOS');
    }
  }
}

class IOSVideoPlayerWidget extends StatelessWidget {
  const IOSVideoPlayerWidget({
    super.key,
    required this.player,
    required this.avPlayerPointer,
  });

  final DarwinVideoPlayerImplementation player;
  final int avPlayerPointer;

  @override
  Widget build(BuildContext context) {
    return UiKitView(
      viewType: 'CinemaAVPlayerView',
      creationParams: avPlayerPointer,
      creationParamsCodec: const StandardMessageCodec(),
      hitTestBehavior: PlatformViewHitTestBehavior.transparent,
      onPlatformViewCreated: (id) {
        print('platform view ready: $id');
      },
    );
  }
}

class MacOSVideoPlayerWidget extends StatelessWidget {
  const MacOSVideoPlayerWidget({
    super.key,
    required this.player,
    required this.avPlayerPointer,
  });

  final DarwinVideoPlayerImplementation player;
  final int avPlayerPointer;

  @override
  Widget build(BuildContext context) {
    return AppKitView(
      viewType: 'CinemaAVPlayerView',
      creationParams: avPlayerPointer,
      creationParamsCodec: const StandardMessageCodec(),
      hitTestBehavior: PlatformViewHitTestBehavior.transparent,
      onPlatformViewCreated: (id) {
        print('platform view ready: $id');
      },
    );
  }
}
