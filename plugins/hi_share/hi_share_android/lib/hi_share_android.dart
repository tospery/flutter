
import 'hi_share_android_platform_interface.dart';

class HiShareAndroid {
  Future<String?> getPlatformVersion() {
    return HiShareAndroidPlatform.instance.getPlatformVersion();
  }
}
