import 'package:first_desktop_application/app-level/widgets/option_name.dart';
import 'package:first_desktop_application/routes/constants.dart';

import 'package:flutter/material.dart';

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
              children: [
                Text('1'),
                Text('1'),
                Text('1'),
                Text('1'),
                Text('1'),
                Text('1'),
                // OptionButton(
                //   buttonText: 'Theming',
                //   onTap: () => Navigator.pushNamed(context, themingRoute),
                // ),
                // OptionButton(
                //   buttonText: 'Solar System',
                //   onTap: () => Navigator.pushNamed(context, solarSystemRoute),
                // ),
                // OptionButton(
                //   buttonText: 'Flipping',
                //   onTap: () => Navigator.pushNamed(context, flippingRoute),
                // ),
                // OptionButton(
                //   buttonText: 'Inking',
                //   onTap: () => Navigator.pushNamed(context, inkingRoute),
                // ),
                // OptionButton(
                //   buttonText: 'LiquidCards',
                //   onTap: () => Navigator.pushNamed(context, liquidCardsRoute),
                // ),
              ],
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

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
