import 'package:hi_share_platform_interface/hi_share_platform_interface.dart';

class HiShare {
  Future<bool> show() {
    return HiSharePlatform.instance.show();
  }
}
