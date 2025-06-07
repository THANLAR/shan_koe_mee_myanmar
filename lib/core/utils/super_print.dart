export 'package:shan_koe_mee_myanmar/core/utils/super_print.dart';
import 'package:logger/logger.dart';

final Logger _logger = Logger(
  printer: PrettyPrinter(
    methodCount: 2,
    errorMethodCount: 8,
    lineLength: 120,
    colors: true,
    printEmojis: true,
    dateTimeFormat: DateTimeFormat.dateAndTime,
  ),
);

void superPrint(
  dynamic message, {
  LogLevel level = LogLevel.info,
  dynamic error,
  StackTrace? stackTrace,
}) {
  switch (level) {
    case LogLevel.verbose:
      _logger.t(message);
      break;
    case LogLevel.debug:
      _logger.d(message);
      break;
    case LogLevel.info:
      _logger.i(message);
      break;
    case LogLevel.warning:
      _logger.w(message);
      break;
    case LogLevel.error:
      _logger.e(message, error: error, stackTrace: stackTrace);
      break;
    case LogLevel.wtf:
      _logger.f(message, error: error, stackTrace: stackTrace);
      break;
  }
}

enum LogLevel { verbose, debug, info, warning, error, wtf }
