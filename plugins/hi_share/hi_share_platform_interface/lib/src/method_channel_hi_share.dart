import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'hi_share_platform.dart';

class MethodChannelHiShare extends HiSharePlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('plugins.jianxiang.com/hi_config_ios');

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
