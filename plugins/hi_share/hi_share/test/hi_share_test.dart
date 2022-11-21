import 'package:flutter_test/flutter_test.dart';
import 'package:hi_share/hi_share.dart';
import 'package:hi_share/hi_share_platform_interface.dart';
import 'package:hi_share/hi_share_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockHiSharePlatform
    with MockPlatformInterfaceMixin
    implements HiSharePlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final HiSharePlatform initialPlatform = HiSharePlatform.instance;

  test('$MethodChannelHiShare is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelHiShare>());
  });

  test('getPlatformVersion', () async {
    HiShare hiSharePlugin = HiShare();
    MockHiSharePlatform fakePlatform = MockHiSharePlatform();
    HiSharePlatform.instance = fakePlatform;

    expect(await hiSharePlugin.getPlatformVersion(), '42');
  });
}
