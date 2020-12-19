import 'package:first_desktop_application/app-level/services/root_service.dart';
import 'package:first_desktop_application/library/library.dart';
import 'package:first_desktop_application/locator.dart';
import 'package:first_desktop_application/routes/constants.dart';
import 'package:first_desktop_application/routes/routes.dart' as routes;
import 'package:first_desktop_application/themed/models/theme_model.dart';
import 'package:first_desktop_application/themed/themes.dart';

import 'package:flutter/foundation.dart'
    show debugDefaultTargetPlatformOverride;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;

  setupLocator();

  LibraryTest().open();

  runApp(
    ChangeNotifierProvider<ThemeSwitcher>(
      create: (_) => ThemeSwitcher(),
      child: MyApp(key: locator<RootService>().rootKey),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
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
                onGenerateRoute: routes.Router.generateRoute,
              );
      },
    );
  }
}
