import 'package:hi_core/src/function.dart';
import 'package:hi_core/src/model/model.dart';

extension MapHiCoreEx<K, V> on Map<K, V> {

  bool? boolValue(K key) => tryBool(this[key]);
  int? intValue(K key) => tryInt(this[key]);
  double? doubleValue(K key) => tryDouble(this[key]);
  String? stringValue(K key) => tryString(this[key]);
  Map<KType, VType>? mapValue<KType, VType>(K key) => tryMap<KType, VType>(this[key]);
  Map<String, dynamic>? jsonValue(K key) => tryJSON(this[key]);

  E? enumValue<E>(K key, {E Function(dynamic)? fromValue}) {
    final value = this[key];
    if (value == null) {
      return null;
    }
    if (value is E) {
      return value as E;
    }
    if (fromValue != null) {
      return fromValue!(value);
    }
    return null;
  }

  M? modelValue<M>(K key, {M Function(dynamic)? fromJson}) {
    final value = this[key];
    if (value == null) {
      return null;
    }
    if (value is M) {
      return value as M;
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

  V? value(List<K> keys) {
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

  Map<K, dynamic> get simplex {
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

  Map<K, V> append(Map<K, V> other) {
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

  Map<String, String> get urlEncoded {
    var queries = <String, String>{};
    this.forEach((key, value) {
      final myKey = tryString(key);
      final myValue = tryString(value);
      if ((myKey?.isNotEmpty ?? false) && ( myValue?.isNotEmpty ?? false)) {
        queries[Uri.encodeComponent(myKey!)] = Uri.encodeComponent(myValue!);
      }
    });
    return queries;
  }

  // => this.entries.map((e) => {
  //   Uri.encodeComponent(tryString(e.key) ?? ''): Uri.encodeComponent(tryString(e.value) ?? ''),
  // });

  Map<K, V> operator +(Map<K, V> other) {
    addAll(other);
    return this;
  }
}
