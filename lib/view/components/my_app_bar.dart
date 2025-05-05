import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/states/theme_state.dart';

const String appBarTitle = 'Notepad';

/// This is a custom app bar that will be used on the entire application
///
/// Counts with a switch theme feature
class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeState>(
      builder:
          (context, state, child) => AppBar(
            /// sets the app bar's title
            title: Text(appBarTitle),

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
          ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
