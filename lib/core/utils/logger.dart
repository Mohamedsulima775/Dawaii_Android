
// lib/core/utils/logger.dart

import 'package:flutter/foundation.dart';

class Logger {
  static const bool _enableLogs = kDebugMode;

  void info(String message) {
    if (_enableLogs) {
      debugPrint('ℹ️ INFO: $message');
    }
  }

  void debug(String message) {
    if (_enableLogs) {
      debugPrint('🔍 DEBUG: $message');
    }
  }

  void warning(String message) {
    if (_enableLogs) {
      debugPrint('⚠️ WARNING: $message');
    }
  }

  void error(String message, {Object? error, StackTrace? stackTrace}) {
    if (_enableLogs) {
      debugPrint('❌ ERROR: $message');
      if (error != null) {
        debugPrint('Error object: $error');
      }
      if (stackTrace != null) {
        debugPrint('Stack trace: $stackTrace');
      }
    }
  }

  void success(String message) {
    if (_enableLogs) {
      debugPrint('✅ SUCCESS: $message');
    }
  }
}
