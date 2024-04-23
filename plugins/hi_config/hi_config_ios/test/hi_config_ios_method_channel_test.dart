import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hi_config_ios/hi_config_ios_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelHiConfigIos platform = MethodChannelHiConfigIos();
  const MethodChannel channel = MethodChannel('hi_config_ios');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
