import 'dart:async';
import 'dart:ui' as UI;
import 'package:flutter/material.dart';

extension ImageProviderHiFlutterEx on ImageProvider {
  Future<UI.Image> image({
    ImageConfiguration imageConfiguration = ImageConfiguration.empty,
  }) async {
    Completer<UI.Image> completer = Completer<UI.Image>();
    ImageStreamListener? listener;
    ImageStream stream = resolve(imageConfiguration);
    listener = ImageStreamListener((ImageInfo frame, bool sync) {
      final UI.Image image = frame.image;
      completer.complete(image);
      stream.removeListener(listener!);
    });
    stream.addListener(listener);
    return completer.future;
  }
}