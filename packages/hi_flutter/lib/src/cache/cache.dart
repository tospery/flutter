import 'package:hi_flutter/hi_flutter.dart';

class HiCache {
  SharedPreferences? _prefs;

  static HiCache? _instance;
  static HiCache shared() {
    _instance ??= HiCache._();
    return _instance!;
  }

  HiCache._() {
    _init();
  }

  void _init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  HiCache._pre(this._prefs);

  static Future<HiCache> ready() async {
    if (_instance == null) {
      var prefs = await SharedPreferences.getInstance();
      _instance = HiCache._pre(prefs);
    }
    return _instance!;
  }

  setBool(String key, bool value) {
    _prefs?.setBool(key, value);
  }

  setInt(String key, int value) {
    _prefs?.setInt(key, value);
  }

  setDouble(String key, double value) {
    _prefs?.setDouble(key, value);
  }

  setString(String key, String value) {
    _prefs?.setString(key, value);
  }

  setStringList(String key, List<String> value) {
    _prefs?.setStringList(key, value);
  }

  remove(String key) {
    _prefs?.remove(key);
  }

  T? get<T>(String key) {
    if (_prefs == null) {
      log('SharedPreferences还没初始化');
    }
    var result = _prefs?.get(key);
    if (result != null) {
      return result as T?;
    }
    return null;
  }

  // Future<bool> store<M extends HiModel>(
  //   String key, {
  //   M? model,
  //   List<M>? models,
  // }) async {
  //   String? string;
  //   if (model != null) {
  //     string = model.toJson().toJsonString();
  //   }
  //   if (string == null && models != null) {
  //     string = models.toJsonString();
  //   }
  //   if (string == null) {
  //     return false;
  //   }
  //   var provider = HiDbProvider<M>();
  //   return await provider.store(key, string);
  // }

  // Future<dynamic> fetch<M extends HiModel>(
  //   String key,
  // ) async {
  //   var provider = HiDbProvider<M>();
  //   return await provider.fetch(key);
  // }

  Future<void> reset() async {
    await HiDbManager.close();
  }
}
