import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'hi_share_ios_method_channel.dart';

abstract class HiShareIosPlatform extends PlatformInterface {
  /// Constructs a HiShareIosPlatform.
  HiShareIosPlatform() : super(token: _token);

  static final Object _token = Object();

  static HiShareIosPlatform _instance = MethodChannelHiShareIos();

  /// The default instance of [HiShareIosPlatform] to use.
  ///
  /// Defaults to [MethodChannelHiShareIos].
  static HiShareIosPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [HiShareIosPlatform] when
  /// they register themselves.
  static set instance(HiShareIosPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
