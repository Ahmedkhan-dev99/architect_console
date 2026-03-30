import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:architect_console/shared/util/global_provider.dart';

/// Theme-aware color helper class
class AppColor {
  final BuildContext context;
  AppColor(this.context);

  bool get isDark => context.watch<GlobalProvider>().isDarkMode;

  Color get bgColor =>
      isDark ? const Color(0xFF1A1A1A) : const Color(0xFFFAFAFA);
  Color get borderColor =>
      isDark ? const Color.fromARGB(255, 69, 69, 69) : const Color(0xFFBEBEBE);
  Color get accentColor =>
      isDark ? const Color(0xFF5CB9E3) : const Color(0xFF3c83a4);
  Color get textColor =>
      isDark ? const Color(0xFFE5E5E5) : const Color(0xFF1A1A1A);
  Color get subTextColor =>
      isDark ? const Color(0xFFE5E5E5) : const Color(0xFF6F6F6F);
}
