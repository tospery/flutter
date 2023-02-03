import 'package:hi_flutter/hi_flutter.dart';

class HiError implements Exception {
  final int code;
  final String? message;
  final dynamic data;

  String? get displayTitle => null;
  String? get displayMessage => message;
  String? get displayImage => null;

  static const okCode = 200;

  HiError(this.code, this.message, {this.data});

  static HiAppError get unknown => HiAppError(1, R.strings.unknown.tr);
  static HiAppError get timeout => HiAppError(2, R.strings.timeout.tr);
  static HiAppError get unlogin => HiAppError(3, R.strings.unlogin.tr);
  static HiAppError get unauthed => HiAppError(4, R.strings.unauthed.tr);
  static HiAppError get dataInvalid => HiAppError(5, R.strings.dataInvalid.tr);
  static HiAppError get dataIsEmpty => HiAppError(6, R.strings.dataIsEmpty.tr);

  @override
  String toString() {
    return '$typeName($code, $message, $data)';
  }
}

class HiNetworkError extends HiError {
  HiNetworkError(super.code, super.message, {super.data});

  @override
  String? get displayTitle => R.strings.networkTitle.tr;

  @override
  String? get displayImage => R.assets.images.errorNetwork;

  static HiNetworkError get disabled =>
      HiNetworkError(1, R.strings.networkDisabled.tr);
  static HiNetworkError get unreachable =>
      HiNetworkError(2, R.strings.networkNotReachable.tr);
}

class HiClientError extends HiError {
  @override
  String? get displayTitle => R.strings.serverTitle.tr;

  @override
  String? get displayImage => R.assets.images.errorServer;

  HiClientError(super.code, super.message, {super.data});
}

class HiServerError extends HiError {
  @override
  String? get displayTitle => R.strings.serverTitle.tr;

  @override
  String? get displayImage => R.assets.images.errorServer;

  HiServerError(super.code, super.message, {super.data});
}

class HiAppError extends HiError {
  HiAppError(super.code, super.message, {super.data});

  @override
  String? get displayTitle => R.strings.abnormalOperation.tr;
}
