import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'method_channel_hi_config.dart';

abstract class HiConfigPlatform extends PlatformInterface {
  HiConfigPlatform() : super(token: _token);

  static final Object _token = Object();

  static HiConfigPlatform _instance = MethodChannelHiConfig();

  static HiConfigPlatform get instance => _instance;

  static set instance(HiConfigPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> baseLink() {
    return _instance.baseLink();
  }
}