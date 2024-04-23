import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'hi_config_method_channel.dart';

abstract class HiConfigPlatform extends PlatformInterface {
  /// Constructs a HiConfigPlatform.
  HiConfigPlatform() : super(token: _token);

  static final Object _token = Object();

  static HiConfigPlatform _instance = MethodChannelHiConfig();

  /// The default instance of [HiConfigPlatform] to use.
  ///
  /// Defaults to [MethodChannelHiConfig].
  static HiConfigPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [HiConfigPlatform] when
  /// they register themselves.
  static set instance(HiConfigPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
