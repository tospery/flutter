import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'hi_capability_method_channel.dart';

abstract class HiCapabilityPlatform extends PlatformInterface {
  /// Constructs a HiCapabilityPlatform.
  HiCapabilityPlatform() : super(token: _token);

  static final Object _token = Object();

  static HiCapabilityPlatform _instance = MethodChannelHiCapability();

  /// The default instance of [HiCapabilityPlatform] to use.
  ///
  /// Defaults to [MethodChannelHiCapability].
  static HiCapabilityPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [HiCapabilityPlatform] when
  /// they register themselves.
  static set instance(HiCapabilityPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
