
import 'hi_share_platform_interface.dart';

class HiShare {
  Future<String?> getPlatformVersion() {
    return HiSharePlatform.instance.getPlatformVersion();
  }
}
