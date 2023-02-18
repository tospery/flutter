import 'package:shared_preferences/shared_preferences.dart';
import 'package:hi_core/hi_core.dart';
import 'db_manager.dart';
import 'db_provider.dart';

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

  set(String key, dynamic value) {
    if (_prefs == null) {
      log('SharedPreferences还没初始化', tag: HiLogTag.cache);
      // TODO 采用throw error，不采用error是为了轻量级
      // return Future<bool>.value(false);
      return;
    }
    if (value == null) {
      remove(key);
      return;
    }
    if (value is bool) {
      _prefs!.setBool(key, value);
    } else if (value is double) {
      _prefs!.setDouble(key, value);
    } else if (value is int) {
      _prefs!.setInt(key, value);
    } else if (value is String) {
      _prefs!.setString(key, value);
    } else if (value is List<String>) {
      _prefs!.setStringList(key, value);
    }
  }

  T? get<T>(String key) {
    if (_prefs == null) {
      log('SharedPreferences还没初始化', tag: HiLogTag.cache);
    }
    var result = _prefs?.get(key);
    if (result == null || result is! T) {
      return null;
    }
    return result as T?;
  }

  remove(String key) {
    _prefs?.remove(key);
  }

  Future<bool> storeObject<M extends HiModel>(
    M model, {
    String? id,
    bool? useDatabase,
  }) async {
    var key = _objectKey(model.typeName.toLowerCase(), id: id);
    log('存储对象: $key', tag: HiLogTag.cache);
    if (useDatabase ?? false) {
      var provider = HiDbProvider<M>();
      return await provider.store(key, model.toJson().toJsonString());
    }
    set(key, model.toJson().toJsonString());
    return true;
  }

  Future<M?> fetchObject<M extends HiModel>(
    M Function(Map<String, dynamic>) fromJson, {
    String? id,
    bool? useDatabase,
  }) async {
    var key = _objectKey(M.toString().toLowerCase(), id: id);
    log('提取对象: $key', tag: HiLogTag.cache);
    if (useDatabase ?? false) {
      var provider = HiDbProvider<M>();
      var json = await provider.fetch(key);
      return json != null && json is Map<String, dynamic> ? fromJson(json) : null;
    }
    var json = get<String>(key)?.toJsonObject();
    return json != null ? fromJson(json) : null;
  }

  Future<bool> storeArray<M extends HiModel>(
    List<M> models, {
    String? page,
  }) async {
    var key = _arrayKey(M.toString().toLowerCase(), page: page);
    log('存储数组: $key', tag: HiLogTag.cache);
    var provider = HiDbProvider<M>();
    return await provider.store(key, models.toJsonString());
  }

  Future<List<M>> fetchArray<M extends HiModel>(
    M Function(Map<String, dynamic>) fromJson, {
    String? page,
  }) async {
    var key = _arrayKey(M.toString().toLowerCase(), page: page);
    log('提取数组: $key', tag: HiLogTag.cache);
    var provider = HiDbProvider<M>();
    var json = await provider.fetch(key);
    return json != null && json is List ? json.map((e) => fromJson(e)).toList() : [];
  }

  Future<void> delete<M extends HiModel>() async {}

  Future<void> reset() async {
    await HiDbManager.close();
  }

  String _objectKey(String type, {String? id}) {
    var key = '$type#object';
    if (id?.isNotEmpty ?? false) {
      key += '#$id';
    }
    return key;
  }

  String _arrayKey(String type, {String? page}) {
    var key = '$type#array';
    if (page?.isNotEmpty ?? false) {
      key += '#$page';
    }
    return key;
  }
}
