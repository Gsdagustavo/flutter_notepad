import 'package:flutter/material.dart';
import 'package:notepad/view/pages/home_page.dart';
import 'package:provider/provider.dart';

import 'model/states/theme_state.dart';

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
