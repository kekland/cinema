import 'package:cinema_core/cinema_core.dart';
import 'package:cinema_darwin/src/gen/darwin_bindings.dart';

class VideoPlayerImplementationDarwin extends VideoPlayerImplementation {
  VideoPlayerImplementationDarwin() {
    _avPlayer = AVPlayer();
  }

  late final AVPlayer _avPlayer;

  @override
  void dispose() {
    _avPlayer.release();
  }
}
