import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'hi_config_platform_interface_method_channel.dart';

abstract class HiConfigPlatformInterfacePlatform extends PlatformInterface {
  /// Constructs a HiConfigPlatformInterfacePlatform.
  HiConfigPlatformInterfacePlatform() : super(token: _token);

  static final Object _token = Object();

  static HiConfigPlatformInterfacePlatform _instance = MethodChannelHiConfigPlatformInterface();

  /// The default instance of [HiConfigPlatformInterfacePlatform] to use.
  ///
  /// Defaults to [MethodChannelHiConfigPlatformInterface].
  static HiConfigPlatformInterfacePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [HiConfigPlatformInterfacePlatform] when
  /// they register themselves.
  static set instance(HiConfigPlatformInterfacePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
