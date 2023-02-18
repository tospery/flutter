import 'package:device_info_plus/device_info_plus.dart';
import 'package:hi_core/hi_core.dart';

class HiDeviceInfo {
  BaseDeviceInfo? _deviceInfo;

  static HiDeviceInfo? _instance;
  static HiDeviceInfo shared() {
    _instance ??= HiDeviceInfo._();
    return _instance!;
  }

  HiDeviceInfo._() {
    init();
  }

  void init() async {
    _deviceInfo ??= await DeviceInfoPlugin().deviceInfo;
  }

  HiDeviceInfo._pre(BaseDeviceInfo deviceInfo) {
    _deviceInfo = deviceInfo;
  }

  static Future<HiDeviceInfo> ready() async {
    if (_instance == null) {
      var deviceInfo = await DeviceInfoPlugin().deviceInfo;
      _instance = HiDeviceInfo._pre(deviceInfo);
    }
    return _instance!;
  }

  String? get name => _deviceInfo?.data.stringForKey(R.parameters.name);
  String? get model => _deviceInfo?.data.stringForKey(R.parameters.model);
  String? get systemName =>
      _deviceInfo?.data.stringForKey(R.parameters.systemName);
  String? get systemVersion =>
      _deviceInfo?.data.stringForKey(R.parameters.systemVersion);
  bool? get isPhysicalDevice =>
      _deviceInfo?.data.boolForKey(R.parameters.isPhysicalDevice);
}