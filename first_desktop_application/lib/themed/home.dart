import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:first_desktop_application/themed/models/theme_model.dart';

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
