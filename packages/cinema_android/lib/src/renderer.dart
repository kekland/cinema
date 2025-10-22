import 'dart:async';
import 'dart:io';

import 'package:cinema_android/src/extensions.dart';
import 'package:cinema_android/src/gen/android_bindings.dart';
import 'package:cinema_core/cinema_core.dart';
import 'package:jni/jni.dart';

class AndroidRendererImplementation extends RendererImplementation {
  @override
  Future<void> compress(Media input, File output) async {
    final presentation = Presentation.createForHeight(720)!;
    final effects = Effects(
      <AudioProcessor>[].toJList(AudioProcessor.type),
      <Effect>[presentation.as(Effect.type)].toJList(Effect.type),
    );

    final mediaItem = input.createMediaItem();
    final editedMediaItemBuilder = EditedMediaItem$Builder(mediaItem);
    editedMediaItemBuilder.setEffects(effects);
    final editedMediaItem = editedMediaItemBuilder.build()!;

    final transformerBuilder = Transformer$Builder(getContext());
    transformerBuilder.setVideoMimeType(MimeTypes.VIDEO_H264);
    transformerBuilder.setAudioMimeType(MimeTypes.AUDIO_AAC);

    final completer = Completer<void>();
    final transformer = transformerBuilder.build()!;
    transformer.addListener(
      Transformer$Listener.implement(
        $Transformer$Listener(
          onCompleted: (_, _) => completer.complete(),
          onError: (_, _, _) {},
          onFallbackApplied: (_, _, _) {},
        ),
      ),
    );
    transformer.start$1(editedMediaItem, output.path.toJString());
    await completer.future;
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }
}
