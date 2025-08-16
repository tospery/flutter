import 'package:hi_cache/hi_cache.dart';
import 'package:hi_network/hi_network.dart';
import 'package:hi_navigator/hi_navigator.dart';
import 'package:hi_flutter/src/utils/app_info.dart';
import 'package:hi_flutter/src/utils/device_info.dart';

class HiFlutter {
  final int pageSize;

  static HiFlutter? _instance;
  static HiFlutter shared() {
    _instance ??= HiFlutter._();
    return _instance!;
  }

  HiFlutter._({
    int? pageSize,
  }) : this.pageSize = pageSize ?? 20;

  static Future<bool> ready({
    int? pageSize,
    String? baseWeb,
    String? codeKeys,
    String? messageKeys,
    String? dataKeys,
  }) async {
    _instance ??= HiFlutter._(pageSize: pageSize);
    await HiCache.ready();
    await HiNavigator.ready(baseWeb: baseWeb);
    await HiNetwork.ready(
      codeKeys: codeKeys,
      messageKeys: messageKeys,
      dataKeys: dataKeys,
    );
    await HiAppInfo.ready();
    await HiDeviceInfo.ready();
    return true;
  }
}
