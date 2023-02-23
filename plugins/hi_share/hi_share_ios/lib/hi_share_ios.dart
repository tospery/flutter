import 'package:flutter/services.dart';
import 'package:hi_share_platform_interface/hi_share_platform_interface.dart';

const MethodChannel _channel =  MethodChannel('plugins.jianxiang.com/hi_share_ios');

class HiShareIOS extends HiSharePlatform {

  static void registerWith() {
    HiSharePlatform.instance = HiShareIOS();
  }

  @override
  Future<String> show() {
    return _channel.invokeMethod<String>(
      'show',
    ).then((String? value) => value ?? 'ios message');
  }

}