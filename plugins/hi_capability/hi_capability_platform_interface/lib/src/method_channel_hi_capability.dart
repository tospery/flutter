import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'hi_capability_platform.dart';

class MethodChannelHiShare extends HiCapabilityPlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('hi_share');

  @override
  Future show({
    required String title,
    required Uint8List imageData,
    required String urlString,
  }) async {
    final result = await methodChannel.invokeMethod(
      'show',
      [title, imageData, urlString],
    );
    return result;
  }
}
