import 'package:first_desktop_application/flipping/data/demo_data.dart';
import 'package:first_desktop_application/flipping/widgets/flight_barcode.dart';
import 'package:first_desktop_application/flipping/widgets/flight_details.dart';
import 'package:first_desktop_application/flipping/widgets/flight_summary.dart';
import 'package:first_desktop_application/flipping/widgets/folding_ticket.dart';
import 'package:flutter/material.dart';

class Ticket extends StatefulWidget {
  static const double nominalOpenHeight = 400; // 160 +160 +80 (_getEntries)
  static const double nominalClosedHeight = 160; // 160

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
  FlightSummary frontCard;
  FlightSummary topCard;
  FlightDetails middleCard;
  FlightBarcode bottomCard;

  bool _isOpen;

  Widget get backCard => Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            color: const Color(0xffdce6ef)),
      );

  @override
  void initState() {
    super.initState();
    _isOpen = false;
    frontCard = FlightSummary(boardingPass: widget.boardingPass);
    middleCard = FlightDetails(boardingPass: widget.boardingPass);
    bottomCard = const FlightBarcode();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleOnTap,
      child: FoldingTicket(
        entries: _getEntries(),
        isOpen: _isOpen,
      ),
    );
  }

  List<FoldEntry> _getEntries() {
    return [
      FoldEntry(height: 160.0, front: topCard),
      FoldEntry(height: 160.0, front: middleCard, back: frontCard),
      FoldEntry(height: 80.0, front: bottomCard, back: backCard)
    ];
  }

  void _handleOnTap() {
    widget.onClick();
    setState(() {
      _isOpen = !_isOpen;
      topCard = FlightSummary(
        boardingPass: widget.boardingPass,
        theme: SummaryTheme.dark,
        isOpen: _isOpen,
      );
    });
  }
}
