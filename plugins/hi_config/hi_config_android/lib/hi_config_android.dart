
import 'hi_config_android_platform_interface.dart';

class HiConfigAndroid {
  Future<String?> getPlatformVersion() {
    return HiConfigAndroidPlatform.instance.getPlatformVersion();
  }
}
