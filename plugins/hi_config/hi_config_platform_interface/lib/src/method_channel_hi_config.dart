import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'hi_config_platform.dart';

class MethodChannelHiConfig extends HiConfigPlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('hi_config');

  @override
  Future<String?> baseLink() async {
    final result = await methodChannel.invokeMethod('baseLink');
    if (result is! String) {
      return null;
    }
    return result;
  }
}
