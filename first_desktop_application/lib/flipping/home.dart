import 'dart:math';

import 'package:first_desktop_application/flipping/data/demo_data.dart';
import 'package:first_desktop_application/flipping/widgets/custom-app-bar.dart';
import 'package:first_desktop_application/flipping/widgets/ticket.dart';

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<BoardingPassData> _boardingPasses = DemoData().boardingPasses;

  final ScrollController _scrollController = ScrollController();

  final List<int> _openTickets = [];

  @override
  Widget build(BuildContext context) {
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
              controller: _scrollController,
              physics: BouncingScrollPhysics(),
              itemCount: _boardingPasses.length,
              itemBuilder: (context, index) {
                return Ticket(
                  boardingPass: _boardingPasses.elementAt(index),
                  onClick: () => _handleClickedTicket(index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  bool _handleClickedTicket(int clickedTicket) {
    // Scroll to ticket position

    // Add or remove the item of the list of open tickets
    _openTickets.contains(clickedTicket)
        ? _openTickets.remove(clickedTicket)
        : _openTickets.add(clickedTicket);

    print('Open Tickets >>> ${_openTickets.length}');

    double openTicketsOffset =
        Ticket.nominalOpenHeight * _getOpenTicketsBefore(clickedTicket);

    double closedTicketsOffset = Ticket.nominalClosedHeight *
        (clickedTicket - _getOpenTicketsBefore(clickedTicket));

    print('OpenTickets $openTicketsOffset ClosedTickets $closedTicketsOffset');

    double offset = openTicketsOffset +
        closedTicketsOffset -
        (Ticket.nominalClosedHeight * .5);

    // Scroll to the clicked element
    _scrollController.animateTo(
      max(0, offset),
      duration: Duration(seconds: 1),
      curve: Interval(.25, 1, curve: Curves.easeOutQuad),
    );

    print('Offset $offset');

    // Return true to stop the notification propagation
    return true;
  }

  // Important for scrollng when multiple tickets are opened...
  int _getOpenTicketsBefore(int ticketIndex) {
    // Search all indexes that are smaller to the current index in the list of indexes of open tickets
    return _openTickets.where((int index) => index < ticketIndex).length;
  }
}
