import 'package:first_desktop_application/flipping/data/demo_data.dart';
import 'package:first_desktop_application/flipping/widgets/flight_summary.dart';
import 'package:first_desktop_application/flipping/widgets/folding_ticket.dart';
import 'package:flutter/material.dart';

class Ticket extends StatefulWidget {
  final BoardingPassData boardingPass;
  final Function onClick;

  const Ticket({
    Key key,
    @required this.boardingPass,
    @required this.onClick,
  }) : super(key: key);

  @override
  _TicketState createState() => _TicketState();
}

class _TicketState extends State<Ticket> {
  bool _isOpen;

  @override
  void initState() {
    super.initState();
    _isOpen = false;
  }

  @override
  Widget build(BuildContext context) {
    //

    return GestureDetector(
      onTap: _handleOnTap,
      // child: FoldingTicket(
      //   isOpen: _isOpen,
      // ),
      child: FlightSummary(boardingPass: widget.boardingPass, isOpen: _isOpen),
    );
  }

  void _handleOnTap() {
    widget.onClick();
    setState(() {
      _isOpen = !_isOpen;
    });
  }
}
