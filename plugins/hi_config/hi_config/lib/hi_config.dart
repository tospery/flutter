
import 'hi_config_platform_interface.dart';

class HiConfig {
  Future<String?> getPlatformVersion() {
    return HiConfigPlatform.instance.getPlatformVersion();
  }
}
