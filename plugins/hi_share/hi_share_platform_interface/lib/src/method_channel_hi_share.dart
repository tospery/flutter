import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'hi_share_platform.dart';

class MethodChannelHiShare extends HiSharePlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('hi_share');

  @override
  Future<String> show() async {
    final result = await methodChannel.invokeMethod<String>('show');
    return result ?? 'none';
  }
}