import 'package:hi_config_platform_interface/hi_config_platform_interface.dart';

class HiConfig {

  static HiConfig? _instance;

  static HiConfig shared() {
    _instance ??= HiConfig._();
    return _instance!;
  }

  HiConfig._();

  Future<String?> baseLink() {
    return HiConfigPlatform.instance.baseLink();
  }
}