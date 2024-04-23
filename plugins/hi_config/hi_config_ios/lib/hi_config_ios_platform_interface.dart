import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'hi_config_ios_method_channel.dart';

abstract class HiConfigIosPlatform extends PlatformInterface {
  /// Constructs a HiConfigIosPlatform.
  HiConfigIosPlatform() : super(token: _token);

  static final Object _token = Object();

  static HiConfigIosPlatform _instance = MethodChannelHiConfigIos();

  /// The default instance of [HiConfigIosPlatform] to use.
  ///
  /// Defaults to [MethodChannelHiConfigIos].
  static HiConfigIosPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [HiConfigIosPlatform] when
  /// they register themselves.
  static set instance(HiConfigIosPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
