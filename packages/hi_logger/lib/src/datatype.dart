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
        return Level.trace;
      case HiLogLevel.debug:
        return Level.debug;
      case HiLogLevel.info:
        return Level.info;
      case HiLogLevel.warning:
        return Level.warning;
      case HiLogLevel.error:
        return Level.error;
    }
  }
}
