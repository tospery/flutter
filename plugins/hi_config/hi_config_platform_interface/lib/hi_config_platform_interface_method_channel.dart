import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'hi_config_platform_interface_platform_interface.dart';

/// An implementation of [HiConfigPlatformInterfacePlatform] that uses method channels.
class MethodChannelHiConfigPlatformInterface extends HiConfigPlatformInterfacePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('hi_config_platform_interface');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
