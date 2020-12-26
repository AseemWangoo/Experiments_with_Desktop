import 'package:first_desktop_application/app-level/home.dart';
import 'package:first_desktop_application/routes/constants.dart';
import 'package:first_desktop_application/solarsystem/home.dart' as ss;
import 'package:first_desktop_application/flipping/home.dart' as flipping;
import 'package:first_desktop_application/inking/home.dart' as inking;
import 'package:first_desktop_application/liquid_cards/home.dart' as liquid;
import 'package:first_desktop_application/travel_cards/home.dart' as travel;
import 'package:first_desktop_application/library/libraryui.dart';
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

      case AppRoutes.homeRoute:
        return _NoAnimationMaterialPageRoute<dynamic>(
          builder: (_) => Home(),
          name: AppRoutes.homeRoute,
        );

      case AppRoutes.themingRoute:
        return _NoAnimationMaterialPageRoute<dynamic>(
          builder: (_) => const MyHomePage(),
          name: AppRoutes.themingRoute,
        );

      case AppRoutes.solarSystemRoute:
        return _NoAnimationMaterialPageRoute<dynamic>(
          builder: (_) => ss.Home(),
          name: AppRoutes.solarSystemRoute,
        );

      case AppRoutes.flippingRoute:
        return _NoAnimationMaterialPageRoute<dynamic>(
          builder: (_) => const flipping.Home(),
          name: AppRoutes.flippingRoute,
        );

      case AppRoutes.inkingRoute:
        return _NoAnimationMaterialPageRoute<dynamic>(
          builder: (_) => const inking.Home(),
          name: AppRoutes.inkingRoute,
        );

      case AppRoutes.liquidCardsRoute:
        return _NoAnimationMaterialPageRoute<dynamic>(
          builder: (_) => const liquid.Home(),
          name: AppRoutes.liquidCardsRoute,
        );

      case AppRoutes.travelCardsRoute:
        return _NoAnimationMaterialPageRoute<dynamic>(
          builder: (_) => const travel.Home(),
          name: AppRoutes.travelCardsRoute,
        );

      case AppRoutes.libraryRoute:
        return _NoAnimationMaterialPageRoute<dynamic>(
          builder: (_) => const LibraryUI(),
          name: AppRoutes.libraryRoute,
        );

      default:
        return _NoAnimationMaterialPageRoute<dynamic>(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
          name: settings.name,
        );
    }
  }
}

/// A MaterialPageRoute without any transition animations.
class _NoAnimationMaterialPageRoute<T> extends MaterialPageRoute<T> {
  _NoAnimationMaterialPageRoute({
    @required WidgetBuilder builder,
    @required String name,
    bool maintainState = true,
    bool fullscreenDialog = false,
  }) : super(
          builder: builder,
          maintainState: maintainState,
          settings: RouteSettings(name: name),
          fullscreenDialog: fullscreenDialog,
        );

  // @override
  // Widget buildPage(
  //   BuildContext context,
  //   Animation<double> animation,
  //   Animation<double> secondaryAnimation,
  // ) {
  //   return builder(context);
  // }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) =>
      child;
}
