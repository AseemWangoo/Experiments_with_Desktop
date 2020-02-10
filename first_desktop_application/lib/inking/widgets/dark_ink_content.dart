import 'package:first_desktop_application/inking/constants.dart';

import 'package:flutter/material.dart';

class DarkInkContent extends StatelessWidget {
  final bool darkMode;

  //TODO: Add scroll

  const DarkInkContent({Key key, this.darkMode = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lightTextColor = Color(0xFFBCFEEA);
    final lightSubHeaderColor = Color(0xFF00EBAC);
    final darkSubHeaderColor = Color(0xFF008F9C);
    final darkTextColor = Color(0xFF210A3B);

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        color: darkMode ? Color(0xFF313466) : Color(0xFFFFFFFF),
        padding: const EdgeInsets.all(37.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              InkingConstants.headerText,
              style: TextStyle(
                fontSize: 36,
                fontFamily: 'Merriweather',
                fontWeight: FontWeight.bold,
                color: darkMode ? lightTextColor : darkTextColor,
                decoration: TextDecoration.none,
              ),
            ),
            Padding(padding: const EdgeInsets.only(top: 24.0)),
            Text(
              InkingConstants.subHeaderText,
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'Merriweather',
                color: darkMode ? lightSubHeaderColor : darkSubHeaderColor,
                decoration: TextDecoration.none,
              ),
            ),
            Padding(padding: const EdgeInsets.only(top: 12)),
            Container(
              height: 1.0,
              color: darkMode ? Color(0x510098A3) : Color(0x512B777E),
            ),
            Padding(padding: const EdgeInsets.only(top: 24.0)),
            Text(
              InkingConstants.bodyText,
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Barlow',
                letterSpacing: 0.5,
                height: 1.5,
                fontWeight: FontWeight.w500,
                color: darkMode ? lightTextColor : darkTextColor,
                decoration: TextDecoration.none,
              ),
            ),
            Padding(padding: const EdgeInsets.only(top: 64.0)),
          ],
        ),
      ),
    );
  }
}
