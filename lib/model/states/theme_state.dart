import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// keeps track of the current Theme State
class ThemeState with ChangeNotifier {
  static const String lightModeKey = 'lightMode';

  /// default theme is light
  ThemeMode _themeMode = ThemeMode.dark;

  ThemeMode get themeMode => _themeMode;

  bool get isLightMode => _themeMode == ThemeMode.light;


  ThemeState() {
    loadTheme();
  }

  /// toggles the current theme (whether is light or dark)
  Future<void> toggleTheme() async {
    _themeMode =
        _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;

    notifyListeners();

    /// saves the current theme on SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(lightModeKey, isLightMode);
  }

  /// toggles the current theme (whether is light or dark)
  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isLightMode = prefs.getBool(lightModeKey) ?? false;

    _themeMode = isLightMode ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }
}
