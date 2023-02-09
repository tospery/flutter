import 'extension/bool.dart';
import 'extension/int.dart';
import 'extension/string.dart';

bool isNotEmpty(String? text) => text?.isNotEmpty ?? false;
bool isEmpty(String? text) => text?.isEmpty ?? true;

bool? hiBool(dynamic any) {
  if (any == null) {
    return null;
  }
  if (any is bool) {
    return any;
  }
  if (any is int) {
    return any.toBool();
  }
  if (any is double) {
    return any.toInt().toBool();
  }
  if (any is String) {
    return any.toBool();
  }
  return null;
}

int? hiInt(dynamic any) {
  if (any == null) {
    return null;
  }
  if (any is bool) {
    return any.toInt();
  }
  if (any is int) {
    return any;
  }
  if (any is double) {
    return any.toInt();
  }
  if (any is String) {
    return any.toInt();
  }
  return null;
}

double? hiDouble(dynamic any) {
  if (any == null) {
    return null;
  }
  if (any is bool) {
    return any.toInt().toDouble();
  }
  if (any is int) {
    return any.toDouble();
  }
  if (any is double) {
    return any;
  }
  if (any is String) {
    return any.toDouble();
  }
  return null;
}

String? hiString(dynamic any) {
  if (any == null) {
    return null;
  }
  if (any is bool) {
    return any.toString();
  }
  if (any is int) {
    return any.toString();
  }
  if (any is double) {
    return any.toString();
  }
  if (any is String) {
    return any;
  }
  return null;
}

Map<String, dynamic>? hiMap(dynamic any) {
  if (any == null) {
    return null;
  }
  if (any is Map<String, dynamic>) {
    return any;
  }
  return null;
}