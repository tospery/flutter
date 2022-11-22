import 'package:flutter_test/flutter_test.dart';
import 'package:hi_share_android/hi_share_android.dart';
import 'package:hi_share_android/hi_share_android_platform_interface.dart';
import 'package:hi_share_android/hi_share_android_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockHiShareAndroidPlatform
    with MockPlatformInterfaceMixin
    implements HiShareAndroidPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final HiShareAndroidPlatform initialPlatform = HiShareAndroidPlatform.instance;

  test('$MethodChannelHiShareAndroid is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelHiShareAndroid>());
  });

  test('getPlatformVersion', () async {
    HiShareAndroid hiShareAndroidPlugin = HiShareAndroid();
    MockHiShareAndroidPlatform fakePlatform = MockHiShareAndroidPlatform();
    HiShareAndroidPlatform.instance = fakePlatform;

    expect(await hiShareAndroidPlugin.getPlatformVersion(), '42');
  });
}
