import 'package:flutter_test/flutter_test.dart';
import 'package:hi_config/hi_config.dart';
import 'package:hi_config/hi_config_platform_interface.dart';
import 'package:hi_config/hi_config_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockHiConfigPlatform
    with MockPlatformInterfaceMixin
    implements HiConfigPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final HiConfigPlatform initialPlatform = HiConfigPlatform.instance;

  test('$MethodChannelHiConfig is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelHiConfig>());
  });

  test('getPlatformVersion', () async {
    HiConfig hiConfigPlugin = HiConfig();
    MockHiConfigPlatform fakePlatform = MockHiConfigPlatform();
    HiConfigPlatform.instance = fakePlatform;

    expect(await hiConfigPlugin.getPlatformVersion(), '42');
  });
}
