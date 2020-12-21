import 'package:first_desktop_application/app-level/constants/brand.links.dart';

import 'package:flutter/material.dart';

import 'widgets/parallax_btn.dart';
import 'widgets/sliver.scaffold.dart';
import 'widgets/top_nav.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    //
    final _nav = Navigator.of(context);

    return SimpleSliverScaffold(
      controller: _controller,
      minHeight: 120.0,
      maxHeight: 120.0,
      menu: TopNavBar(controller: _controller),
      children: [
        // const BgWRidget(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: _addToList(_nav),
            ),
          ),
        ),
      ],
    );

    // return Scaffold(
    //   body: SafeArea(
    //     child: Stack(
    //       children: [
    //         const BgWidget(),
    //         Padding(
    //           padding: const EdgeInsets.all(8.0),
    //           child: Center(
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //               children: [
    //                 OptionButton(
    //                   buttonText: 'Theming',
    //                   onTap: () => Navigator.pushNamed(context, themingRoute),
    //                 ),
    //                 OptionButton(
    //                   buttonText: 'Solar System',
    //                   onTap: () =>
    //                       Navigator.pushNamed(context, solarSystemRoute),
    //                 ),
    //                 OptionButton(
    //                   buttonText: 'Flipping',
    //                   onTap: () => Navigator.pushNamed(context, flippingRoute),
    //                 ),
    //                 OptionButton(
    //                   buttonText: 'Inking',
    //                   onTap: () => Navigator.pushNamed(context, inkingRoute),
    //                 ),
    //                 OptionButton(
    //                   buttonText: 'LiquidCards',
    //                   onTap: () =>
    //                       Navigator.pushNamed(context, liquidCardsRoute),
    //                 ),
    //                 // OptionButton(
    //                 //   buttonText: 'TravelCards',
    //                 //   onTap: () =>
    //                 //       Navigator.pushNamed(context, travelCardsRoute),
    //                 // ),
    //               ],
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }

  List<Widget> _addToList(NavigatorState nav) {
    const _optionRoutes = OptionAndRoutes.optionRoutes;
    const _linkRoutes = OptionAndRoutes.linksRoutes;
    final listOfWidgets = <Widget>[];

    for (final _optionRoute in _optionRoutes.entries) {
      listOfWidgets.add(
        GestureDetector(
          onTap: () => nav.pushNamed(_optionRoute.value),
          child: ParallaxButton(
            text: _optionRoute.key,
            isFavorite: false,
            medium: _linkRoutes[_optionRoute.key].first,
            website: _linkRoutes[_optionRoute.key][1],
            youtubeLink: _linkRoutes[_optionRoute.key].last,
          ),
        ),
      );
    }

    return listOfWidgets;
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
