import 'package:flutter/material.dart';
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
    required Image image,
    required Uri url,
  }) {
    return _instance.show(title: title, image: image, url: url);
  }
}
