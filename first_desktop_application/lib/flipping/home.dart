import 'package:first_desktop_application/flipping/data/demo_data.dart';
import 'package:first_desktop_application/flipping/widgets/custom-app-bar.dart';
import 'package:first_desktop_application/flipping/widgets/ticket.dart';

import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //
    final List<BoardingPassData> _boardingPasses = DemoData().boardingPasses;

    return Scaffold(
      appBar: CustomAppBar(
        appBarIconsColor: Color(0xFF212121),
        height: 60.0,
      ),
      backgroundColor: Color(0xFFf0f0f0),
      body: Flex(
        direction: Axis.vertical,
        children: [
          Expanded(
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: _boardingPasses.length,
              itemBuilder: (context, index) {
                return Ticket(boardingPass: _boardingPasses.elementAt(index));
              },
            ),
          ),
        ],
      ),
    );
  }
}
