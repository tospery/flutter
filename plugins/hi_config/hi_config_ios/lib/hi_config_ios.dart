
import 'hi_config_ios_platform_interface.dart';

class HiConfigIos {
  Future<String?> getPlatformVersion() {
    return HiConfigIosPlatform.instance.getPlatformVersion();
  }
}
