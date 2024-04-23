
import 'hi_capability_platform_interface.dart';

class HiCapability {
  Future<String?> getPlatformVersion() {
    return HiCapabilityPlatform.instance.getPlatformVersion();
  }
}
