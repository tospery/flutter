import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hi_share/hi_share_method_channel.dart';

void main() {
  MethodChannelHiShare platform = MethodChannelHiShare();
  const MethodChannel channel = MethodChannel('hi_share');

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
