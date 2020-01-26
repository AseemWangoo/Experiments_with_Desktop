import 'package:flutter/material.dart';

class FlightBarcode extends StatelessWidget {
  const FlightBarcode({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14.0),
        child: Image.asset('assets/images/barcode.png'),
      ),
    );
  }
}
