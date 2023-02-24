import 'package:hi_core/src/function.dart';
import 'package:hi_core/src/model/model.dart';

extension MapEx<K, V> on Map<K, V> {
  bool? boolForKey(K key) => hiBool(this[key]);
  int? intForKey(K key) => hiInt(this[key]);
  double? doubleForKey(K key) => hiDouble(this[key]);
  String? stringForKey(K key) => hiString(this[key]);
  Map<String, dynamic>? mapForKey(K key) => hiMap(this[key]);
  List<T>? listForKey<T>(K key) => hiList<T>(this[key]);
  T? enumForKey<T>(K key, T Function(dynamic) fromValue) => hiEnum(this[key], fromValue);

  M? model<M extends HiModel>(K key, M Function(dynamic) fromJson,) {
    var json = mapForKey(key);
    if (json == null) {
      return null;
    }
    return fromJson(json);
  }

  List<M>? list<M extends HiModel>(K key, M Function(dynamic) fromJson,) {
    var value = this[key];
    if (value == null) {
      return null;
    }
    if (value is! List) {
      return null;
    }
    if (value is List<M>) {
      return value;
    }
    if (value is! List<Map<String, dynamic>>) {
      return null;
    }
    var list = value.map((json) => fromJson(json)).toList();
    return list;
  }

  // V? valueForKey(K key, {String? delimiter}) {
  //   if (delimiter?.isEmpty ?? true) {
  //     return this[key];
  //   }
  //   var keys = key.toString().split(delimiter!);
  //   for (var element in keys) {
  //     if (element.startsWith('!')) {
  //       var realKey = element; // .removePrefix('!');
  //       var result = this[realKey];
  //       if (result == null || result is! bool) {
  //         continue;
  //       }
  //       return !result as V;
  //     }
  //     var result = this[element];
  //     if (result != null) {
  //       return result;
  //     }
  //   }
  //   return null;
  // }

  V? valueForKeys(List<K> keys) {
    V? v;
    for (K k in keys) {
      V? temp = this[k];
      if (temp != null) {
        v = temp;
        break;
      }
    }
    return v;
  }

  Map<K, dynamic> get singleValueMap {
    Map<K, dynamic> result = {};
    forEach((key, value) {
      if (value is List) {
        result[key] = value.first;
      } else {
        result[key] = value;
      }
    });
    return result;
  }

  // String toJsonString() => convert.json.encode(this);

  Map<K, V> addIfNotExist(Map<K, V> other) {
    if (other.isEmpty) {
      return this;
    }
    var result = <K, V>{};
    result.addAll(this);
    for (var key in other.keys) {
      if (result[key] != null) {
        continue;
      }
      result[key] = other[key] as V;
    }
    return result;
  }

  Map<K, V> operator +(Map<K, V> other) {
    addAll(other);
    return this;
  }
}
