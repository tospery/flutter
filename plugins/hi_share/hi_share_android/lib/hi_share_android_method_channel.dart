import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'hi_share_android_platform_interface.dart';

/// An implementation of [HiShareAndroidPlatform] that uses method channels.
class MethodChannelHiShareAndroid extends HiShareAndroidPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('hi_share_android');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
