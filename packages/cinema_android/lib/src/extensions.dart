import 'package:cinema_android/src/gen/android_bindings.dart';
import 'package:cinema_core/cinema_core.dart';
import 'package:jni/jni.dart';

extension MediaExtensions on Media {
  MediaItem createMediaItem() {
    return switch (this) {
      FileMedia m => MediaItem.fromUri(m.path.toJString())!,
      NetworkMedia m => MediaItem.fromUri(m.url.toJString())!,
      // _ => throw UnsupportedError('Unsupported media type for AVAsset creation'),
    };
  }
}

Context getContext() {
  return Context.fromReference(Jni.getCachedApplicationContext());
}