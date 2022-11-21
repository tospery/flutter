
import 'hi_share_ios_platform_interface.dart';

class HiShareIos {
  Future<String?> getPlatformVersion() {
    return HiShareIosPlatform.instance.getPlatformVersion();
  }
}
