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

  @override
  String toString() {
    return '$typeName($code, $message, $data)';
  }
}

class HiNetworkError extends HiError {
  HiNetworkError(super.code, super.message, {super.data});

  @override
  String? get displayTitle => hiJson(data)?.value<String>(HiParameter.title) ?? R.strings.networkErrorTitle;

  @override
  String? get displayImage => R.assets.image.errorNetwork;

  static HiNetworkError get disabled =>
      HiNetworkError(1, R.strings.networkDisabledMessage);
  static HiNetworkError get unreachable =>
      HiNetworkError(2, R.strings.networkUnreachableMessage);
}

class HiUserError extends HiError {
  @override
  String? get displayTitle => R.strings.serverTitle;

  @override
  String? get displayImage => R.assets.image.errorServer;

  static HiUserError get unlogin => HiUserError(1, R.strings.unlogin);
  static HiUserError get expired => HiUserError(2, R.strings.expired);

  HiUserError(super.code, super.message, {super.data});
}

class HiServerError extends HiError {
  @override
  String? get displayTitle => R.strings.serverTitle;

  @override
  String? get displayImage => R.assets.image.errorServer;

  static HiServerError get dataInvalid => HiServerError(1, R.strings.dataInvalid);
  static HiServerError get dataIsEmpty => HiServerError(2, R.strings.dataIsEmpty);

  HiServerError(super.code, super.message, {super.data});
}

class HiAppError extends HiError {
  HiAppError(super.code, super.message, {super.data});

  static HiAppError get unknown => HiAppError(1, R.strings.unknown);
  static HiAppError get navigation => HiAppError(2, R.strings.navigation);

  @override
  String? get displayTitle => R.strings.abnormalOperation;
}
