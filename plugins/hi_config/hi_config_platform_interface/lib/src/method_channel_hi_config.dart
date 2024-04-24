import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'hi_config_platform.dart';

class MethodChannelHiConfig extends HiConfigPlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('plugins.jianxiang.com/hi_config');

  @override
  Future<String?> baseLink() async {
    return methodChannel.invokeMethod<String>('baseLink');
  }
}
