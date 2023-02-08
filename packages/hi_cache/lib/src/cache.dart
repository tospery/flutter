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
      log('SharedPreferences还没初始化');
      // YJX_TODO 采用throw error，不采用error是为了轻量级
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
      log('SharedPreferences还没初始化');
    }
    var result = _prefs?.get(key);
    if (result != null) {
      return result as T?;
    }
    return null;
  }

  remove(String key) {
    _prefs?.remove(key);
  }

  Future<bool> storeObject<M extends HiModel>(
      M model, {
        String? id,
      }) async {
    var provider = HiDbProvider<M>();
    return await provider.store(
        _objectKey(id),
        model.toJson().toJsonString()
    );
  }

  Future<M?> fetchObject<M extends HiModel>(M Function(Map<String, dynamic>) fromJson, {
    String? id,
  }) async {
    var provider = HiDbProvider<M>();
    var json = await provider.fetch(_objectKey(id));
    if (json == null || json is! Map<String, dynamic>) {
      return null;
    }
    return fromJson(json);
  }

  Future<bool> storeArray<M extends HiModel>(
      List<M> models, {
        String? page,
      }) async {
    var provider = HiDbProvider<M>();
    return await provider.store(
        _arrayKey(page),
        models.toJsonString()
    );
  }

  Future<List<M>> fetchArray<M extends HiModel>(M Function(Map<String, dynamic>) fromJson, {
    String? page,
  }) async {
    var provider = HiDbProvider<M>();
    var json = await provider.fetch(_arrayKey(page));
    if (json == null || json is! List) {
      return [];
    }
    return json.map((e) => fromJson(e)).toList();
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
  //
  // Future<M> fetch<M extends HiModel>(
  //   String key,
  //     M Function(Map<String, dynamic>) fromJson,
  // ) async {
  //   var provider = HiDbProvider<M>();
  //   // return await provider.fetch(key);
  //   var json = await provider.fetch(key);
  //   if (json is! Map<String, dynamic>) {
  //     log('获取到的类型不匹配');
  //   }
  //   var object = fromJson(json);
  //   return object;
  // }

  Future<void> reset() async {
    await HiDbManager.close();
  }

  String _objectKey(String? id) {
    return id?.isNotEmpty ?? false ? 'id#$id' : 'object';
  }

  String _arrayKey(String? page) {
    return page?.isNotEmpty ?? false ? 'page#$page' : 'array';
  }

}
