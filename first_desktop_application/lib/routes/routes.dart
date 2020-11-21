import 'package:first_desktop_application/app-level/home.dart';
import 'package:first_desktop_application/routes/constants.dart';
import 'package:first_desktop_application/solarsystem/home.dart' as ss;
import 'package:first_desktop_application/flipping/home.dart' as flipping;
import 'package:first_desktop_application/inking/home.dart' as inking;
import 'package:first_desktop_application/liquid_cards/home.dart' as liquid;
import 'package:first_desktop_application/travel_cards/home.dart' as travel;
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
        return MaterialPageRoute<dynamic>(builder: (_) => Home());

      case themingRoute:
        return MaterialPageRoute<dynamic>(builder: (_) => const MyHomePage());

      case solarSystemRoute:
        return MaterialPageRoute<dynamic>(builder: (_) => ss.Home());

      case flippingRoute:
        return MaterialPageRoute<dynamic>(
            builder: (_) => const flipping.Home());

      case inkingRoute:
        return MaterialPageRoute<dynamic>(builder: (_) => const inking.Home());

      case liquidCardsRoute:
        return MaterialPageRoute<dynamic>(builder: (_) => const liquid.Home());

      case travelCardsRoute:
        return MaterialPageRoute<dynamic>(builder: (_) => const travel.Home());

      default:
        return MaterialPageRoute<dynamic>(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
