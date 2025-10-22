import 'package:cinema_core/cinema_core.dart';
import 'package:flutter/material.dart';

abstract class VideoPlayerImplementation {
  void setMedia(Media media);

  void play();
  void pause();

  Widget buildWidget();

  @mustCallSuper
  void dispose();
}
