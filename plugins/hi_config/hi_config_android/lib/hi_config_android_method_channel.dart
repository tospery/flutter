import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'hi_config_android_platform_interface.dart';

/// An implementation of [HiConfigAndroidPlatform] that uses method channels.
class MethodChannelHiConfigAndroid extends HiConfigAndroidPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('hi_config_android');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
