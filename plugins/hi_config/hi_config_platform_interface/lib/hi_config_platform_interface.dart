
import 'hi_config_platform_interface_platform_interface.dart';

class HiConfigPlatformInterface {
  Future<String?> getPlatformVersion() {
    return HiConfigPlatformInterfacePlatform.instance.getPlatformVersion();
  }
}
