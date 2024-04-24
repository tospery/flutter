import 'package:flutter/services.dart';
import 'package:hi_config_platform_interface/hi_config_platform_interface.dart';

const MethodChannel _channel =
MethodChannel('plugins.jianxiang.com/hi_config_android');

class HiConfigAndroid extends HiConfigPlatform {
  static void registerWith() {
    HiConfigPlatform.instance = HiConfigAndroid();
  }

  @override
  Future<String?> baseLink() async {
    return _channel.invokeMethod('baseLink');
  }
}
