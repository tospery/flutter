import 'package:package_info_plus/package_info_plus.dart';

class HiAppInfo {
  PackageInfo? _packageInfo;

  static HiAppInfo? _instance;
  static HiAppInfo shared() {
    _instance ??= HiAppInfo._();
    return _instance!;
  }

  HiAppInfo._() {
    init();
  }

  void init() async {
    _packageInfo ??= await PackageInfo.fromPlatform();
  }

  HiAppInfo._pre(PackageInfo prefs) {
    _packageInfo = prefs;
  }

  static Future<HiAppInfo> ready() async {
    if (_instance == null) {
      var prefs = await PackageInfo.fromPlatform();
      _instance = HiAppInfo._pre(prefs);
    }
    return _instance!;
  }

  String get name => _packageInfo!.appName;
  String get version => _packageInfo!.version;
  String get buildNumber => _packageInfo!.buildNumber;
  String get packageName => _packageInfo!.packageName;
}
