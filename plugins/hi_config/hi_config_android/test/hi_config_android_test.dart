import 'package:flutter_test/flutter_test.dart';
import 'package:hi_config_android/hi_config_android.dart';
import 'package:hi_config_android/hi_config_android_platform_interface.dart';
import 'package:hi_config_android/hi_config_android_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockHiConfigAndroidPlatform
    with MockPlatformInterfaceMixin
    implements HiConfigAndroidPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final HiConfigAndroidPlatform initialPlatform = HiConfigAndroidPlatform.instance;

  test('$MethodChannelHiConfigAndroid is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelHiConfigAndroid>());
  });

  test('getPlatformVersion', () async {
    HiConfigAndroid hiConfigAndroidPlugin = HiConfigAndroid();
    MockHiConfigAndroidPlatform fakePlatform = MockHiConfigAndroidPlatform();
    HiConfigAndroidPlatform.instance = fakePlatform;

    expect(await hiConfigAndroidPlugin.getPlatformVersion(), '42');
  });
}
