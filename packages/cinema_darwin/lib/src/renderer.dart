import 'dart:async';
import 'dart:io';

import 'package:cinema_core/cinema_core.dart';
import 'package:cinema_darwin/src/extensions.dart';
import 'package:cinema_darwin/src/gen/darwin_bindings.dart';
import 'package:objective_c/objective_c.dart';

class DarwinRendererImplementation extends RendererImplementation {
  DarwinRendererImplementation();

  @override
  Future<void> compress(Media input, File output) async {
    final avAsset = input.createAVAsset();
    final exportSession = AVAssetExportSession.exportSessionWithAsset(
      avAsset,
      presetName: AVAssetExportPreset1280x720,
    )!;

    exportSession.outputFileType = AVFileTypeMPEG4;
    exportSession.outputURL = NSURL.fileURLWithPath(output.path.toNSString());

    final completer = Completer<void>();
    exportSession.exportAsynchronouslyWithCompletionHandler(
      ObjCBlock_ffiVoid.listener(() {
        completer.complete();
      }),
    );

    await completer.future;
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }
}
