import 'package:flutter/foundation.dart';

class Logger {
  final String className;

  Logger._(this.className);

  void success(String successMessage) {
    if (kDebugMode) {
      print("{$className} 📗: $successMessage");
    }
  }

  void info(String infoMessage) {
    if (kDebugMode) {
      print("{$className} 📓: $infoMessage");
    }
  }

  void debug(String debugMessage) {
    if (kDebugMode) {
      print("{$className} 📘: $debugMessage");
    }
  }

  void warn(String warningMessage) {
    if (kDebugMode) {
      print("{$className} 📙: $warningMessage");
    }
  }

  void error(String errorMessage) {
    if (kDebugMode) {
      print("{$className} 📕: $errorMessage");
    }
  }

  static Logger getLogger(String className) {
    return Logger._(className);
  }
}
