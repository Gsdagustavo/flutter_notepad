import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/states/theme_state.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
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
