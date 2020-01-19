import 'package:first_desktop_application/routes/constants.dart';
import 'package:first_desktop_application/routes/routes.dart';
import 'package:first_desktop_application/themed/models/theme_model.dart';
import 'package:first_desktop_application/themed/themes.dart';

import 'package:flutter/foundation.dart'
    show debugDefaultTargetPlatformOverride;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;

  runApp(
    ChangeNotifierProvider<ThemeSwitcher>(
      builder: (_) => ThemeSwitcher(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //

    return Consumer<ThemeSwitcher>(
      builder: (_, themeModel, __) {
        final _model = themeModel;

        return MaterialApp(
          initialRoute: homeRoute,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: _model.darkModeOn() ? ThemeMode.dark : ThemeMode.light,
          onGenerateRoute: Router.generateRoute,
        );
      },
    );
  }
}
