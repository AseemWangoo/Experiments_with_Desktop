import 'package:first_desktop_application/routes/constants.dart';
import 'package:first_desktop_application/routes/routes.dart';
import 'package:first_desktop_application/themed/models/theme_model.dart';
import 'package:first_desktop_application/themed/themes.dart';

import 'package:flutter/foundation.dart'
    show debugDefaultTargetPlatformOverride;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

GlobalKey<_MyAppState> rootKey = GlobalKey();

void main() {
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;

  runApp(
    ChangeNotifierProvider<ThemeSwitcher>(
      builder: (_) => ThemeSwitcher(),
      child: MyApp(key: rootKey),
    ),
  );
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _errorMessage;

  void onError(String message) {
    if (mounted) setState(() => _errorMessage = message);
  }

  @override
  Widget build(BuildContext context) {
    //

    return Consumer<ThemeSwitcher>(
      builder: (_, themeModel, __) {
        final _model = themeModel;

        return _errorMessage != null
            ? ErrorWidget(_errorMessage)
            : MaterialApp(
                initialRoute: homeRoute,
                debugShowCheckedModeBanner: false,
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                themeMode:
                    _model.darkModeOn() ? ThemeMode.dark : ThemeMode.light,
                onGenerateRoute: Router.generateRoute,
              );
      },
    );
  }
}
