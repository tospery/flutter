import 'cache/cache.dart';
import 'manager/hi_package_manager.dart';

class HiFlutter {
  static Future<bool> ready() async {
    await HiCache.ready();
    await HiPackageManager.ready();
    return true;
  }
}
