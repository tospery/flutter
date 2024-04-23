import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'hi_config_android_method_channel.dart';

abstract class HiConfigAndroidPlatform extends PlatformInterface {
  /// Constructs a HiConfigAndroidPlatform.
  HiConfigAndroidPlatform() : super(token: _token);

  static final Object _token = Object();

  static HiConfigAndroidPlatform _instance = MethodChannelHiConfigAndroid();

  /// The default instance of [HiConfigAndroidPlatform] to use.
  ///
  /// Defaults to [MethodChannelHiConfigAndroid].
  static HiConfigAndroidPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [HiConfigAndroidPlatform] when
  /// they register themselves.
  static set instance(HiConfigAndroidPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
