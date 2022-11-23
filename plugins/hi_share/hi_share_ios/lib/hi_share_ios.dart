import 'package:flutter/services.dart';
import 'package:hi_share_platform_interface/hi_share_platform_interface.dart';

const MethodChannel _channel =  MethodChannel('plugins.tospery.com/hi_share_ios');

class HiShareIOS extends HiSharePlatform {

  static void registerWith() {
    HiSharePlatform.instance = HiShareIOS();
  }

  @override
  Future<bool> show() {
    return _channel.invokeMethod<bool>(
      'show',
    ).then((bool? value) => value ?? false);
  }

}