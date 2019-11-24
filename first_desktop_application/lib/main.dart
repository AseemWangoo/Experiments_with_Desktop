import 'package:first_desktop_application/themed/models/theme_model.dart';
import 'package:first_desktop_application/themed/themes.dart';
import 'package:flare_flutter/flare_actor.dart';
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
          debugShowCheckedModeBanner: false,
          // darkTheme: ThemeData(
          //   primarySwatch: Colors.orange,
          // ),
          // darkTheme: ThemeData.dark(),
          // theme: ThemeData.light(),
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: _model.darkModeOn() ? ThemeMode.dark : ThemeMode.light,
          home: MyHomePage(),
        );
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //

    final _model = Provider.of<ThemeSwitcher>(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: _model.darkModeOn()
                ? const Icon(Icons.wb_sunny)
                : const Icon(Icons.star),
            onPressed: () => _model.turnOnDarkMode(!_model.darkModeOn()),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('Yayyy, I am running on desktop !!! '),
            SizedBox(
              width: 200.0,
              height: 200.0,
              child: FlareActor(
                'assets/animations/bob.flr',
                alignment: Alignment.center,
                fit: BoxFit.cover,
                animation: 'Stand',
              ),
            ),
            Text('Current Mode : ${_model.currentTheme()}'),
          ],
        ),
      ),
    );
  }
}
