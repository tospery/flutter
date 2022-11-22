import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'hi_share_android_method_channel.dart';

abstract class HiShareAndroidPlatform extends PlatformInterface {
  /// Constructs a HiShareAndroidPlatform.
  HiShareAndroidPlatform() : super(token: _token);

  static final Object _token = Object();

  static HiShareAndroidPlatform _instance = MethodChannelHiShareAndroid();

  /// The default instance of [HiShareAndroidPlatform] to use.
  ///
  /// Defaults to [MethodChannelHiShareAndroid].
  static HiShareAndroidPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [HiShareAndroidPlatform] when
  /// they register themselves.
  static set instance(HiShareAndroidPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
