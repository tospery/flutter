import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'hi_capability_platform_interface.dart';

/// An implementation of [HiCapabilityPlatform] that uses method channels.
class MethodChannelHiCapability extends HiCapabilityPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('hi_capability');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
