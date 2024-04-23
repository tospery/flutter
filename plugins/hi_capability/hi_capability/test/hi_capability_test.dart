import 'package:flutter_test/flutter_test.dart';
import 'package:hi_capability/hi_capability.dart';
import 'package:hi_capability/hi_capability_platform_interface.dart';
import 'package:hi_capability/hi_capability_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockHiCapabilityPlatform
    with MockPlatformInterfaceMixin
    implements HiCapabilityPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final HiCapabilityPlatform initialPlatform = HiCapabilityPlatform.instance;

  test('$MethodChannelHiCapability is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelHiCapability>());
  });

  test('getPlatformVersion', () async {
    HiCapability hiCapabilityPlugin = HiCapability();
    MockHiCapabilityPlatform fakePlatform = MockHiCapabilityPlatform();
    HiCapabilityPlatform.instance = fakePlatform;

    expect(await hiCapabilityPlugin.getPlatformVersion(), '42');
  });
}
