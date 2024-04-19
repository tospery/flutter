import 'parameter.dart';
import 'function.dart';
import 'resource/r.dart';
import 'extension/object.dart';
import 'extension/map.dart';

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
  static HiError get navigation => HiError(2, R.strings.navigation);

  @override
  String toString() {
    return '$typeName($code, $message, $data)';
  }
}

class HiNetworkError extends HiError {
  HiNetworkError(super.code, super.message, {super.data});

  @override
  String? get displayTitle => tryJSON(data)?.stringValue(HiParameter.title) ?? R.strings.networkErrorTitle;

  @override
  String? get displayImage => R.assets.image.errorNetwork;

  static HiNetworkError get disabled =>
      HiNetworkError(1, R.strings.networkDisabledMessage);
  static HiNetworkError get unreachable =>
      HiNetworkError(2, R.strings.networkUnreachableMessage);
}

class HiServerError extends HiError {
  @override
  String? get displayTitle => R.strings.serverErrorTitle;

  @override
  String? get displayImage => R.assets.image.errorServer;

  static const notFoundCode = 404;

  static HiServerError get dataInvalid => HiServerError(1, R.strings.serverDataInvalidMessage);
  static HiServerError get listIsEmpty => HiServerError(2, R.strings.serverListIsEmptyMessage);

  HiServerError(super.code, super.message, {super.data});
}

class HiUserError extends HiError {
  @override
  String? get displayTitle => R.strings.userErrorTitle;

  @override
  String? get displayImage => R.assets.image.errorServer;

  static HiUserError get unlogin => HiUserError(1, R.strings.userNotLoginedIn);
  static HiUserError get expired => HiUserError(2, R.strings.userLoginExpired);

  HiUserError(super.code, super.message, {super.data});
}

class HiAppError extends HiError {
  HiAppError(super.code, super.message, {super.data});

  @override
  String? get displayTitle => R.strings.abnormalOperation;
}
