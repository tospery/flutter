import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hi_share_ios/hi_share_ios_method_channel.dart';

void main() {
  MethodChannelHiShareIos platform = MethodChannelHiShareIos();
  const MethodChannel channel = MethodChannel('hi_share_ios');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
