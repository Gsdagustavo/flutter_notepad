import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../model/states/theme_state.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// This is a custom app bar that will be used on the entire application
///
/// Counts with a switch theme feature
class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeState>(
      builder: (context, state, child) {

        return AppBar(
          /// sets the app bar's title based on the user's system language
          title: Text(AppLocalizations.of(context)!.appTitle),

          /// makes the title to appear on the center of the app bar
          centerTitle: true,

          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),

              /// adds an icon button to change the app's theme (light or dark)
              child: IconButton(
                onPressed: () => state.toggleTheme(),
                icon: Icon(
                  state.isLightMode ? Icons.light_mode : Icons.dark_mode,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
