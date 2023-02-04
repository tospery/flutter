import 'dart:convert';
import '../core/error.dart';

extension ObjectEx on Object {
  String get typeName => runtimeType.toString();
  String get instanceName => toString().split('.').last;
  String toJsonString() => jsonEncode(this);

  HiError get hiError {
    // YJX_TODO CastError
    if (this is HiError) {
      return this as HiError;
    }
    return HiAppError(-1, this.toString());
  }
}
