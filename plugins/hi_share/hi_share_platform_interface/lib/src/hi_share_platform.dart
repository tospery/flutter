import 'package:flutter/foundation.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'method_channel_hi_share.dart';

abstract class HiSharePlatform extends PlatformInterface {
  HiSharePlatform() : super(token: _token);

  static final Object _token = Object();

  static HiSharePlatform _instance = MethodChannelHiShare();

  static HiSharePlatform get instance => _instance;

  static set instance(HiSharePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future show({
    required String title,
    required Uint8List imageData,
    required String urlString,
  }) {
    return _instance.show(title: title, imageData: imageData, urlString: urlString);
  }
}
