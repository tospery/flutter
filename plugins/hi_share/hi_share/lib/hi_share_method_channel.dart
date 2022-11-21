import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'hi_share_platform_interface.dart';

/// An implementation of [HiSharePlatform] that uses method channels.
class MethodChannelHiShare extends HiSharePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('hi_share');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
