import 'dart:developer' as dev;

import 'package:flutter/foundation.dart';

class AppLogger {
  AppLogger._();

  static bool _showLogs = false;
  static bool get showLogs => _showLogs;

  static void setLogger({required bool showLogs}) {
    _showLogs = showLogs;
  }

  static void log(Object? e) {
    if (_showLogs) dev.log("$e");
  }
}

printInDebug(dynamic message) {
  if (kDebugMode) {
    print(message);
  }
}
