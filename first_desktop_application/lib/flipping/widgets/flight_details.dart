import 'package:first_desktop_application/flipping/data/demo_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FlightDetails extends StatelessWidget {
  final BoardingPassData boardingPass;

  TextStyle get titleTextStyle => const TextStyle(
        fontFamily: 'OpenSans',
        fontSize: 11,
        height: 1,
        letterSpacing: .2,
        fontWeight: FontWeight.w600,
        color: Color(0xffafafaf),
      );

  TextStyle get contentTextStyle => const TextStyle(
        fontFamily: 'Oswald',
        fontSize: 16,
        height: 1.8,
        letterSpacing: .3,
        color: Color(0xff083e64),
      );

  const FlightDetails({Key key, this.boardingPass}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Gate'.toUpperCase(), style: titleTextStyle),
                Text(boardingPass.gate, style: contentTextStyle),
              ]),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Zone'.toUpperCase(), style: titleTextStyle),
                Text(boardingPass.zone.toString(), style: contentTextStyle),
              ]),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Seat'.toUpperCase(), style: titleTextStyle),
                Text(boardingPass.seat, style: contentTextStyle),
              ]),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Class'.toUpperCase(), style: titleTextStyle),
                Text(boardingPass.flightClass, style: contentTextStyle),
              ]),
            ],
          ),
          //
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Flight'.toUpperCase(), style: titleTextStyle),
                Text(boardingPass.flightNumber, style: contentTextStyle),
              ]),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Departs'.toUpperCase(), style: titleTextStyle),
                Text(
                    DateFormat('MMM d, H:mm')
                        .format(boardingPass.departs)
                        .toUpperCase(),
                    style: contentTextStyle),
              ]),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Arrives'.toUpperCase(), style: titleTextStyle),
                Text(
                  DateFormat('MMM d, H:mm')
                      .format(boardingPass.arrives)
                      .toUpperCase(),
                  style: contentTextStyle,
                )
              ]),
            ],
          ),
        ],
      ),
    );
  }
}
