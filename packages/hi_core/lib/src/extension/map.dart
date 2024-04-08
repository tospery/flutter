import 'package:hi_core/src/function.dart';
import 'package:hi_core/src/model/model.dart';

extension MapHiCoreEx<K, V> on Map<K, V> {
  T? value<T>(
      K key, {
        T Function(dynamic)? fromValue,
        T Function(dynamic)? fromJson,
      }) {
    var value = this[key];
    if (value == null) {
      return null;
    }
    if (value is T) {
      return value as T;
    }
    if (T == bool) {
      return tryBool(value) as T?;
    }
    if (T == int) {
      return tryInt(value) as T?;
    }
    if (T == double) {
      return tryDouble(value) as T?;
    }
    if (T == String) {
      return tryString(value) as T?;
    }
    if (T == Map) {
      return tryJSON(value) as T?;
    }
    if (fromValue != null) {
      return fromValue!(value);
    }
    if (fromJson != null) {
      return fromJson!(value);
    }
    return null;
  }

  List<T>? list<T>(K key, {
    T Function(dynamic)? fromValue,
    T Function(dynamic)? fromJson,
  }) {
    var value = this[key];
    if (value == null || value is! List) {
      return null;
    }
    if (value is List<T>) {
      return value;
    }
    if (fromValue != null) {
      return value.map((e) => fromValue!(e)).toList();
    }
    if (fromJson != null) {
      value.map((e) => fromJson!(e)).toList();
    }
    return null;
  }

  List<E>? enums<E>(K key, {E Function(dynamic)? fromValue}) {
    var value = this[key];
    if (value == null || value is! List) {
      return null;
    }
    if (value is List<E>) {
      return value;
    }
    if (fromValue == null) {
      return null;
    }
    var enums = value.map((e) => fromValue!(e)).toList();
    return enums;
  }

  Map<String, String>? get queries => map((key, value) => MapEntry(key.toString(), value?.toString() ?? ''));

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
