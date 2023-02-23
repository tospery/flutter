import 'package:flutter/material.dart';
import 'package:hi_share_platform_interface/hi_share_platform_interface.dart';

class HiShare {
  Future show({
    required String title,
    required Image image,
    required Uri url,
  }) {
    return HiSharePlatform.instance.show(
      title: title,
      image: image,
      url: url,
    );
  }
}
