import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'hi_config_platform.dart';

class MethodChannelHiConfig extends HiConfigPlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('hi_config');

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