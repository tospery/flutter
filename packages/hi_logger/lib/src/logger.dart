import 'package:hi_logger/src/datatype.dart';
import 'package:logger/logger.dart';

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
  HiLogger.shared().log(
    (tag != null ? '【$tag】$message' : message),
    level: level,
  );
}
