import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:notepad/model/states/note_state.dart';
import 'package:notepad/view/pages/home_page.dart';
import 'package:provider/provider.dart';

import 'model/states/theme_state.dart';

/// The title of the app
const String appTitle = 'Notepad';

/// I always let it off for style purposes
const bool debugShowCheckedModeBanner = false;

/// Entry point
void main() {
  runApp(
    MultiProvider(
      providers: [
        /// Theme state provider
        ChangeNotifierProvider(create: (context) => ThemeState()),

        /// Note state provider
        ChangeNotifierProvider(create: (context) => NoteState()),
      ],

      child: const MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: MyApp(),
      ),
    ),
  );
}

/// Main app that will show the HomePage on when run
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeState>(
      builder: (context, state, child) {
        return MaterialApp(
          title: appTitle,
          debugShowCheckedModeBanner: debugShowCheckedModeBanner,

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

          /// defines the routes of the app (in this case, only [HomePage])
          routes: {'/': (_) => const HomePage()},

          /// defines the [HomePage] ('/') as the initial route of the app
          ///
          /// this means the same as "home: const HomePage()"
          initialRoute: '/',
        );
      },
    );
  }
}
