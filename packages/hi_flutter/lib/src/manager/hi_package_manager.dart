import 'package:package_info_plus/package_info_plus.dart';

class HiPackageManager {
  PackageInfo? _packageInfo;

  static HiPackageManager? _instance;
  static HiPackageManager shared() {
    _instance ??= HiPackageManager._();
    return _instance!;
  }

  HiPackageManager._() {
    init();
  }

  void init() async {
    _packageInfo ??= await PackageInfo.fromPlatform();
  }

  HiPackageManager._pre(PackageInfo prefs) {
    _packageInfo = prefs;
  }

  static Future<HiPackageManager> ready() async {
    if (_instance == null) {
      var prefs = await PackageInfo.fromPlatform();
      _instance = HiPackageManager._pre(prefs);
    }
    return _instance!;
  }

  String get name => _packageInfo!.appName;
  String get version => _packageInfo!.version;
  String get buildNumber => _packageInfo!.buildNumber;
  String get packageName => _packageInfo!.packageName;
}
