import 'package:flutter_test/flutter_test.dart';
import 'package:hi_config_platform_interface/hi_config_platform_interface.dart';
import 'package:hi_config_platform_interface/hi_config_platform_interface_platform_interface.dart';
import 'package:hi_config_platform_interface/hi_config_platform_interface_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockHiConfigPlatformInterfacePlatform
    with MockPlatformInterfaceMixin
    implements HiConfigPlatformInterfacePlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final HiConfigPlatformInterfacePlatform initialPlatform = HiConfigPlatformInterfacePlatform.instance;

  test('$MethodChannelHiConfigPlatformInterface is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelHiConfigPlatformInterface>());
  });

  test('getPlatformVersion', () async {
    HiConfigPlatformInterface hiConfigPlatformInterfacePlugin = HiConfigPlatformInterface();
    MockHiConfigPlatformInterfacePlatform fakePlatform = MockHiConfigPlatformInterfacePlatform();
    HiConfigPlatformInterfacePlatform.instance = fakePlatform;

    expect(await hiConfigPlatformInterfacePlugin.getPlatformVersion(), '42');
  });
}
