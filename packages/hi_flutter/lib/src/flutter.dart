import 'package:hi_cache/hi_cache.dart';
import 'package:hi_network/hi_network.dart';
import 'package:hi_flutter/src/utils/package_manager.dart';

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
    List<String>? codeKeys,
    List<String>? messageKeys,
    List<String>? dataKeys,
  }) async {
    _instance ??= HiFlutter._(pageSize: pageSize);
    await HiCache.ready();
    await HiNetwork.ready(codeKeys: codeKeys, messageKeys: messageKeys, dataKeys: dataKeys,);
    await HiPackageManager.ready();
    return true;
  }
}