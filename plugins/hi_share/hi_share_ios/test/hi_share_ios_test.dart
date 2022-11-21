import 'package:flutter_test/flutter_test.dart';
import 'package:hi_share_ios/hi_share_ios.dart';
import 'package:hi_share_ios/hi_share_ios_platform_interface.dart';
import 'package:hi_share_ios/hi_share_ios_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockHiShareIosPlatform
    with MockPlatformInterfaceMixin
    implements HiShareIosPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final HiShareIosPlatform initialPlatform = HiShareIosPlatform.instance;

  test('$MethodChannelHiShareIos is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelHiShareIos>());
  });

  test('getPlatformVersion', () async {
    HiShareIos hiShareIosPlugin = HiShareIos();
    MockHiShareIosPlatform fakePlatform = MockHiShareIosPlatform();
    HiShareIosPlatform.instance = fakePlatform;

    expect(await hiShareIosPlugin.getPlatformVersion(), '42');
  });
}
