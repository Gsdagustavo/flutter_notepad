import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
          (context, themeState, _) => MaterialApp(
            title: 'Notepad',

            theme: themeState.lightTheme ? ThemeData.light() : ThemeData.dark(),
            debugShowCheckedModeBanner: false,
            routes: {'/': (context) => const HomePage()},

            initialRoute: '/',
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
            body: Center(
              child: IconButton(
                onPressed: () => themeState.toggleTheme(),
                icon: Icon(
                  themeState.lightTheme ? Icons.light_mode : Icons.dark_mode,
                ),
              ),
            ),
          ),
    );
  }
}

class ThemeState with ChangeNotifier {
  bool _lightTheme = true;

  bool get lightTheme => _lightTheme;

  /// toggles the current theme (whether is light or dark)
  void toggleTheme() {
    _lightTheme = !_lightTheme;
    debugPrint(_lightTheme.toString());
    notifyListeners();
  }
}
