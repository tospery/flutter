import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'hi_config_ios_platform_interface.dart';

/// An implementation of [HiConfigIosPlatform] that uses method channels.
class MethodChannelHiConfigIos extends HiConfigIosPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('hi_config_ios');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
