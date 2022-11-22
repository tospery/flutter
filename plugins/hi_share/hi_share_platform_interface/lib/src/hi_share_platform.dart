import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'method_channel_hi_share.dart';

abstract class HiSharePlatform extends PlatformInterface {
  /// Constructs a HiSharePlatform.
  HiSharePlatform() : super(token: _token);

  static final Object _token = Object();

  static HiSharePlatform _instance = MethodChannelHiShare();

  /// The default instance of [HiSharePlatform] to use.
  ///
  /// Defaults to [MethodChannelHiShare].
  static HiSharePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [HiSharePlatform] when
  /// they register themselves.
  static set instance(HiSharePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}