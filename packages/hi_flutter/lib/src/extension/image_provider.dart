import 'dart:async';
import 'dart:ui' as UI;
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

extension ImageProviderHiFlutterEx on ImageProvider {
  Future<UI.Image> image({
    ImageConfiguration configuration = ImageConfiguration.empty,
  }) async {
    Completer<UI.Image> completer = Completer<UI.Image>();
    ImageStreamListener? listener;
    ImageStream stream = resolve(configuration);
    listener = ImageStreamListener((ImageInfo frame, bool sync) {
      final UI.Image image = frame.image;
      completer.complete(image);
      stream.removeListener(listener!);
    });
    stream.addListener(listener);
    return completer.future;
  }

  Future<Uint8List?> uint8List({
    ImageConfiguration configuration = ImageConfiguration.empty,
    UI.ImageByteFormat format = UI.ImageByteFormat.png,
  }) async {
    var img = await image(configuration: configuration);
    var data = await img.toByteData(format: format);
    var list = data?.buffer.asUint8List();
    return Future<Uint8List?>.value(list);
  }

}