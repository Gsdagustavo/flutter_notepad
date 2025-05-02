import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/states/theme_state.dart';
import '../components/my_app_bar.dart';

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
