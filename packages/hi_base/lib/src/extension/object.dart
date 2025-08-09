import 'dart:convert';

extension ObjectHiBaseEx on Object {
  String get typeName => runtimeType.toString();
  String get instanceName => toString().split('.').last;
  String toJsonString() => jsonEncode(this);

  Map<String, dynamic>? get map {
    if (this is! Map<String, dynamic>) {
      return null;
    }
    return this as Map<String, dynamic>;
  }
}
