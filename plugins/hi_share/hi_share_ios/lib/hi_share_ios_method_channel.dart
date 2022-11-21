import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'hi_share_ios_platform_interface.dart';

/// An implementation of [HiShareIosPlatform] that uses method channels.
class MethodChannelHiShareIos extends HiShareIosPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('hi_share_ios');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
