import 'dart:developer';
import 'package:flutter/foundation.dart';


class Logger {
  static const String _yellow = '\x1B[33m';
  static const String _red = '\x1B[31m';
  static const String _blue = '\x1B[34m';
  static const String _green = '\x1B[32m';
  static const String _reset = '\x1B[0m';

  ////! Logs a warning message in yellow text if the app is in debug mode.
  static void printWarning(Object obj) {
    if (kDebugMode) {
      log('$_yellow$obj$_reset');
    }
  }

  ////! Logs an error message in red text if the app is in debug mode.
  static void printError(Object obj) {
    if (kDebugMode) {
      log('$_red$obj$_reset');
    }
  }

  ////! Logs an informational message in blue text if the app is in debug mode.
  static void printInfo(Object obj) {
    if (kDebugMode) {
      log('$_blue$obj$_reset');
    }
  }

  ////! Logs a success or completion message in green text if the app is in debug mode.
  static void printDone(Object obj) {
    if (kDebugMode) {
      log('$_green$obj$_reset');
    }
  }
}
