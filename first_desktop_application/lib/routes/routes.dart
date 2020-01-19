import 'package:first_desktop_application/app-level/home.dart';
import 'package:first_desktop_application/routes/constants.dart';
import 'package:first_desktop_application/solarsystem/home.dart' as ss;
import 'package:first_desktop_application/themed/home.dart';

import 'package:flutter/material.dart';

class Router {
  /// ----------------------------------------------------------
  /// Creates the Routes Options for the app....
  /// ----------------------------------------------------------
  static Route<dynamic> generateRoute(RouteSettings settings) {
    //Begin...

    switch (settings.name) {
      //Begin...

      case homeRoute:
        return MaterialPageRoute(builder: (_) => Home());

      case themingRoute:
        return MaterialPageRoute(builder: (_) => MyHomePage());

      case solarSystemRoute:
        return MaterialPageRoute(builder: (_) => ss.Home());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
