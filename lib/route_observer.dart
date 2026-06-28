import 'dart:developer';

import 'package:flutter/material.dart';

class AppNavigationObserver extends NavigatorObserver {
  String? currentRoute;
  String? previousRoute;

  /// ANSI COLORS
  static const String purple = '\x1B[95m';

  /// ANSI STYLES
  static const String bold = '\x1B[1m';

  /// RESET
  static const String reset = '\x1B[0m';

  String formatLog(String message) {
    return '$bold$purple$message$reset';
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    this.previousRoute = previousRoute?.settings.name;

    currentRoute = route.settings.name;

    log(
      formatLog('''
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 PUSH NAVIGATION
➡️ CURRENT : ${route.settings.name}
⬅️ PREVIOUS: ${this.previousRoute}
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
'''),
    );

    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    currentRoute = previousRoute?.settings.name;

    log(
      formatLog('''
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🔙 POP NAVIGATION
❌ POPPED : ${route.settings.name}
➡️ CURRENT: $currentRoute
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
'''),
    );

    super.didPop(route, previousRoute);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    currentRoute = newRoute?.settings.name;

    previousRoute = oldRoute?.settings.name;

    log(
      formatLog('''
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
♻️ REPLACE NAVIGATION
🆕 NEW : ${newRoute?.settings.name}
🗑️ OLD : ${oldRoute?.settings.name}
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
'''),
    );

    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }
}
