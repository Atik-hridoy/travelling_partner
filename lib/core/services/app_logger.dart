import 'package:flutter/foundation.dart';

/// ------------------------------------------------------------------
/// High-Visibility Console Logger & Tracer for Voyenta Firebase Operations
/// ------------------------------------------------------------------
class AppLogger {
  static final List<String> _historyLogs = [];

  static List<String> get historyLogs => List.unmodifiable(_historyLogs);

  static void info(String message, {String tag = 'INFO'}) {
    final log = '🔵 [$tag] $message';
    _record(log);
    debugPrint(log);
  }

  static void success(String message, {String tag = 'SUCCESS'}) {
    final log = '🟢 [$tag] $message';
    _record(log);
    debugPrint(log);
  }

  static void dataSend(String collection, String docId, Map<String, dynamic> data) {
    final log = '📥 [FIRESTORE SEND] Document: "$collection/$docId"\n   Data Payload: $data';
    _record(log);
    debugPrint(log);
  }

  static void dataReceive(String collection, String docId, Map<String, dynamic>? data) {
    final log = '📤 [FIRESTORE GET] Document: "$collection/$docId"\n   Result: ${data ?? "null/empty"}';
    _record(log);
    debugPrint(log);
  }

  static void error(String title, Object error, {StackTrace? stackTrace, String? troubleshootingHint}) {
    final logBuffer = StringBuffer()
      ..writeln('--------------------------------------------------')
      ..writeln('🔴 [ERROR TRACE] $title')
      ..writeln('❌ Error Details: $error');

    if (troubleshootingHint != null) {
      logBuffer.writeln('💡 TROUBLESHOOTING HINT: $troubleshootingHint');
    }
    logBuffer.writeln('--------------------------------------------------');

    final logString = logBuffer.toString();
    _record(logString);
    debugPrint(logString);
  }

  static void _record(String entry) {
    _historyLogs.add('[${DateTime.now().toIso8601String()}] $entry');
    if (_historyLogs.length > 100) {
      _historyLogs.removeAt(0);
    }
  }

  static void printFullHistory() {
    debugPrint('========= 📜 VOYENTA APP LOG HISTORY =========');
    for (var log in _historyLogs) {
      debugPrint(log);
    }
    debugPrint('==============================================');
  }
}
