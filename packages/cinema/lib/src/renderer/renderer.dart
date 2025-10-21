import 'dart:io';

import 'package:cinema_core/cinema_core.dart';
import 'package:cinema_android/cinema_android.dart';
import 'package:cinema_darwin/cinema_darwin.dart';

RendererImplementation _createRendererImplementation() {
  if (Platform.isAndroid) return AndroidRendererImplementation();
  if (Platform.isIOS || Platform.isMacOS) return DarwinRendererImplementation();
  throw UnsupportedError('Renderer is not supported on this platform');
}

class Renderer extends RendererImplementation {
  Renderer();

  late final _implementation = _createRendererImplementation();

  @override
  Future<void> compress(Media input, File output) => _implementation.compress(input, output);

  @override
  void dispose() => _implementation.dispose();
}
