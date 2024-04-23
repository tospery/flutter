import 'package:flutter_test/flutter_test.dart';
import 'package:hi_config_ios/hi_config_ios.dart';
import 'package:hi_config_ios/hi_config_ios_platform_interface.dart';
import 'package:hi_config_ios/hi_config_ios_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockHiConfigIosPlatform
    with MockPlatformInterfaceMixin
    implements HiConfigIosPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final HiConfigIosPlatform initialPlatform = HiConfigIosPlatform.instance;

  test('$MethodChannelHiConfigIos is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelHiConfigIos>());
  });

  test('getPlatformVersion', () async {
    HiConfigIos hiConfigIosPlugin = HiConfigIos();
    MockHiConfigIosPlatform fakePlatform = MockHiConfigIosPlatform();
    HiConfigIosPlatform.instance = fakePlatform;

    expect(await hiConfigIosPlugin.getPlatformVersion(), '42');
  });
}
