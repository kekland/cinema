import 'package:cinema_core/cinema_core.dart';
import 'package:cinema_darwin/cinema_darwin.dart';
import 'package:cinema_darwin/src/extensions.dart';
import 'package:cinema_darwin/src/gen/darwin_bindings.dart';
import 'package:flutter/widgets.dart';
import 'package:objective_c/objective_c.dart';

class DarwinVideoPlayerImplementation extends VideoPlayerImplementation {
  DarwinVideoPlayerImplementation() {
    _avPlayer = AVPlayer();
  }

  late final AVPlayer _avPlayer;
  AVPlayerItem? _currentItem;

  @override
  void setMedia(Media media) {
    final avAsset = media.createAVAsset();
    _currentItem = AVPlayerItem.playerItemWithAsset(avAsset);
    _avPlayer.replaceCurrentItemWithPlayerItem(_currentItem);
  }

  @override
  void play() {
    _avPlayer.play();
  }

  @override
  void pause() {
    _avPlayer.pause();
  }

  @override
  void dispose() {
    _currentItem?.release();
    _avPlayer.release();
  }

  @override
  Widget buildWidget() {
    return DarwinVideoPlayerWidget(
      player: this,
      avPlayerPointer: _avPlayer.ref.pointer.address,
    );
  }
}
