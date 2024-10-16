import 'package:logger/logger.dart';

LoggerInterface get log => LoggerInterface();

class LoggerInterface {
  final _logger = Logger(
    printer: PrettyPrinter(methodCount: 10),
  );

  final _loggerNoStack = Logger(
    printer: PrettyPrinter(methodCount: 0),
  );

  final _loggerScreenNoStack = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      printEmojis: false,
    ),
  );

  void d(dynamic message) {
    _loggerNoStack.d(message);
  }

  void i(dynamic message) {
    _loggerNoStack.i(message);
  }

  void s(dynamic message) {
    _loggerScreenNoStack.d('🤳 $message');
  }

  void wtf(dynamic message, [dynamic error]) {
    _logger.e(message, error: error);
  }
}
