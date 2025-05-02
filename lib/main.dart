import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeState(), child: const MyApp(),),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notepad',

      /// Todo: implement theme toggling

      debugShowCheckedModeBanner: false,
      routes: {'/': (context) => const HomePage()},

      initialRoute: '/',
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Hello World!')));
  }
}

class ThemeState with ChangeNotifier {
  bool _lightTheme = true;

  bool get lightTheme => _lightTheme;

  /// toggles the current theme (whether is light or dark)
  void toggleTheme() {
    _lightTheme = !_lightTheme;
    notifyListeners();
  }
}
