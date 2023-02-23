import 'package:hi_share_platform_interface/hi_share_platform_interface.dart';

class HiShare {
  Future<String> show() {
    return HiSharePlatform.instance.show();
  }
}
