import 'dart:convert';

extension ObjectEx on Object {
  String get typeName => runtimeType.toString();
  String get instanceName => toString().split('.').last;
  String toJsonString() => jsonEncode(this);
}
