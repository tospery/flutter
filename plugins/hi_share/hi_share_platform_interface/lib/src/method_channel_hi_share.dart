import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'hi_share_platform.dart';

class MethodChannelHiShare extends HiSharePlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('hi_share');

  @override
  Future show({
    required String title,
    required Image image,
    required Uri url,
  }) async {
    final result = await methodChannel.invokeMethod(
      'show',
      [title, image, url],
    );
    return result;
  }
}
