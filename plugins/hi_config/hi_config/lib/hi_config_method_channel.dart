import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'hi_config_platform_interface.dart';

/// An implementation of [HiConfigPlatform] that uses method channels.
class MethodChannelHiConfig extends HiConfigPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('hi_config');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
