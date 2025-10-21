import 'dart:io';

import 'package:cinema_core/cinema_core.dart';
import 'package:flutter/widgets.dart';

abstract class RendererImplementation {
  RendererImplementation();

  Future<void> compress(Media input, File output);

  @mustCallSuper
  void dispose();
}
