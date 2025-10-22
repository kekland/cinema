import 'dart:io';

import 'package:cinema/cinema.dart';
import 'package:cinema_darwin/cinema_darwin.dart';
import 'package:flutter/src/widgets/framework.dart';

VideoPlayerImplementation _createPlayerImplementation() {
  if (Platform.isIOS || Platform.isMacOS) return DarwinVideoPlayerImplementation();
  throw UnsupportedError('Renderer is not supported on this platform');
}

class VideoPlayer extends VideoPlayerImplementation {
  VideoPlayer() : _implementation = _createPlayerImplementation();

  late final VideoPlayerImplementation _implementation;

  @override
  void setMedia(Media media) => _implementation.setMedia(media);

  @override
  void play() => _implementation.play();

  @override
  void pause() => _implementation.pause();

  @override
  void dispose() => _implementation.dispose();

  @override
  Widget buildWidget() => _implementation.buildWidget();
}
