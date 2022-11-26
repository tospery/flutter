import 'package:flutter/services.dart';
import 'package:hi_share_platform_interface/hi_share_platform_interface.dart';

const MethodChannel _channel =  MethodChannel('plugins.tospery.com/hi_share_android');

class HiShareAndroid extends HiSharePlatform {

  static void registerWith() {
    HiSharePlatform.instance = HiShareAndroid();
  }

  @override
  Future<bool> show() {
    return _channel.invokeMethod<bool>(
      'show',
    ).then((bool? value) => value ?? false);
  }

}