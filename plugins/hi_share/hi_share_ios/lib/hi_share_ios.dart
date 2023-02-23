import 'package:flutter/services.dart';
import 'package:hi_share_platform_interface/hi_share_platform_interface.dart';

const MethodChannel _channel =
    MethodChannel('plugins.jianxiang.com/hi_share_ios');

class HiShareIOS extends HiSharePlatform {
  static void registerWith() {
    HiSharePlatform.instance = HiShareIOS();
  }

  @override
  Future show({
    required String title,
    required Uint8List imageData,
    required String urlString,
  }) {
    return _channel.invokeMethod('show', [title, imageData, urlString]);
  }
}
