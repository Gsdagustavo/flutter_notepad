import 'package:flutter/material.dart';

/// keeps track of the current Theme State
class ThemeState with ChangeNotifier {
  static const String appThemeModeKey = 'appThemeMode';

  /// default theme is light
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  bool get isLightMode => _themeMode == ThemeMode.light;

  /// toggles the current theme (whether is light or dark)
  void toggleTheme() {
    _themeMode =
        _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
