import 'dart:developer' as dev;
import 'package:logger/logger.dart';

class HiLogTag {
  static const core = 'Core';
  static const cache = 'Cache';
  static const navigator = 'Navigator';
  static const network = 'Network';
  static const tabBar = 'TabBar';
  static const dialog = 'Dialog';
  static const frame = 'Frame';
  static const login = 'Login';
}

enum HiLogLevel {
  verbose,
  debug,
  info,
  warning,
  error;

  Level get rawValue {
    switch (this) {
      case HiLogLevel.verbose:
        return Level.verbose;
      case HiLogLevel.debug:
        return Level.debug;
      case HiLogLevel.info:
        return Level.info;
      case HiLogLevel.warning:
        return Level.warning;
      case HiLogLevel.error:
        return Level.error;
      default:
        return Level.debug;
    }
  }
}

class HiLogger {
  final _logger = Logger(printer: SimplePrinter(printTime: true));

  static HiLogger? _instance;
  static HiLogger shared() {
    _instance ??= HiLogger._();
    return _instance!;
  }

  HiLogger._();

  void log(dynamic message, {HiLogLevel level = HiLogLevel.debug}) {
    _logger.log(level.rawValue, message);
  }
}

void log(dynamic message, {HiLogLevel level = HiLogLevel.debug, String? tag}) {
  HiLogger.shared()
      .log((tag != null ? '【$tag】$message' : message), level: level);
}
