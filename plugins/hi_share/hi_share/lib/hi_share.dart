import 'package:flutter/foundation.dart';
import 'package:hi_share_platform_interface/hi_share_platform_interface.dart';

class HiShare {

  static HiShare? _instance;

  static HiShare shared() {
    _instance ??= HiShare._();
    return _instance!;
  }

  HiShare._();

  Future show({
    required String title,
    required Uint8List imageData,
    required String urlString,
  }) {
    return HiSharePlatform.instance.show(
      title: title,
      imageData: imageData,
      urlString: urlString,
    );
  }
}
