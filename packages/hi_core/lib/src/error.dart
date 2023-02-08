import 'resource/r.dart';
import 'extension/object.dart';

class HiError implements Exception {
  final int code;
  final String? message;
  final dynamic data;

  String? get displayTitle => null;
  String? get displayMessage => message;
  String? get displayImage => null;

  static const okCode = 200;

  HiError(this.code, this.message, {this.data});

  static HiError get none => HiError(0, R.strings.none);
  static HiError get unknown => HiError(1, R.strings.unknown);
  static HiError get timeout => HiError(2, R.strings.timeout);
  static HiError get navigation => HiError(3, R.strings.navigation);
  static HiError get dataInvalid => HiError(4, R.strings.dataInvalid);
  static HiError get dataIsEmpty => HiError(5, R.strings.dataIsEmpty);
  // static HiError get userNotLoginedIn => HiError(6, R.strings.userNotLoginedIn);
  // static HiError get userLoginExpired => HiError(7, R.strings.userLoginExpired);
  // static HiError get networkNotConnected => HiError(8, R.strings.networkNotConnected);
  // static HiError get networkNotReachable => HiError(9, R.strings.networkNotReachable);

  @override
  String toString() {
    return '$typeName($code, $message, $data)';
  }
}

class HiNetworkError extends HiError {
  HiNetworkError(super.code, super.message, {super.data});

  @override
  String? get displayTitle => R.strings.networkTitle;

  @override
  String? get displayImage => R.assets.images.errorNetwork;

  static HiNetworkError get disabled =>
      HiNetworkError(1, R.strings.networkDisabled);
  static HiNetworkError get unreachable =>
      HiNetworkError(2, R.strings.networkNotReachable);
}

class HiUserError extends HiError {
  @override
  String? get displayTitle => R.strings.serverTitle;

  @override
  String? get displayImage => R.assets.images.errorServer;

  static HiUserError get unlogin => HiUserError(1, R.strings.unlogin);
  static HiUserError get unauthed => HiUserError(2, R.strings.unauthed);

  HiUserError(super.code, super.message, {super.data});
}

class HiServerError extends HiError {
  @override
  String? get displayTitle => R.strings.serverTitle;

  @override
  String? get displayImage => R.assets.images.errorServer;

  HiServerError(super.code, super.message, {super.data});
}

class HiAppError extends HiError {
  HiAppError(super.code, super.message, {super.data});

  @override
  String? get displayTitle => R.strings.abnormalOperation;
}

//
// class HiClientError extends HiError {
//   @override
//   String? get displayTitle => R.strings.serverTitle;
//
//   @override
//   String? get displayImage => R.assets.images.errorServer;
//
//   HiClientError(super.code, super.message, {super.data});
// }
//
