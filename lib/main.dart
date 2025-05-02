import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(
    /// provider to keep track of the current ThemeState of the App
    ChangeNotifierProvider(
      create: (context) => ThemeState(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeState>(
      builder:
          (context, state, child) => MaterialApp(
            title: 'Notepad',
            debugShowCheckedModeBanner: false,

            /// sets the theme mode based on the current ThemeState
            themeMode: state.themeMode,

            /// sets the light theme
            theme: ThemeData(
              brightness: Brightness.light,
              primarySwatch: Colors.blue,
            ),

            /// sets the dark theme
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              primarySwatch: Colors.blue,
            ),

            home: const HomePage(),
          ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeState>(
      builder:
          (context, themeState, _) => Scaffold(
            appBar: const MyAppBar(),

            body: Center(child: Text('Hello World!')),
          ),
    );
  }
}

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Consumer<ThemeState>(
      builder:
          (context, state, child) => AppBar(
            title: Text('Notepad'),
            centerTitle: true,
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: IconButton(
                  onPressed: () => state.toggleTheme(),
                  icon: Icon(
                    state.isLightMode ? Icons.light_mode : Icons.dark_mode,
                  ),
                ),
              ),
            ],
          ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

/// keeps track of the current Theme State
class ThemeState with ChangeNotifier {
  static const String appThemeModeKey = 'appThemeMode';

  /// default theme is light
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  bool get isLightMode => _themeMode == ThemeMode.light;

  late final SharedPreferences _sharedPreferences;

  /// toggles the current theme (whether is light or dark)
  void toggleTheme() {
    _themeMode =
        _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}