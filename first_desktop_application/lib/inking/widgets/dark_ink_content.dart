import 'package:first_desktop_application/inking/constants.dart';

import 'package:flutter/material.dart';

class DarkInkContent extends StatelessWidget {
  final bool darkMode;

  // TODO(Aseem): Add scroll

  const DarkInkContent({Key key, this.darkMode = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const lightTextColor = Color(0xFFBCFEEA);
    const lightSubHeaderColor = Color(0xFF00EBAC);
    const darkSubHeaderColor = Color(0xFF008F9C);
    const darkTextColor = Color(0xFF210A3B);

    return SingleChildScrollView(
      child: Container(
        color: darkMode ? const Color(0xFF313466) : const Color(0xFFFFFFFF),
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
            const Padding(padding: EdgeInsets.only(top: 24.0)),
            Text(
              InkingConstants.subHeaderText,
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'Merriweather',
                color: darkMode ? lightSubHeaderColor : darkSubHeaderColor,
                decoration: TextDecoration.none,
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 12)),
            Container(
              height: 1.0,
              color:
                  darkMode ? const Color(0x510098A3) : const Color(0x512B777E),
            ),
            const Padding(padding: EdgeInsets.only(top: 24.0)),
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
            const Padding(padding: EdgeInsets.only(top: 64.0)),
          ],
        ),
      ),
    );
  }
}
