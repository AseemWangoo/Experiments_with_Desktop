import 'dart:ui';

import 'package:flutter/cupertino.dart';

class AppColors {
  AppColors._();

  static Color orangeAccent = const Color(0xfff1a35d);
  static Color orangeAccentLight = const Color(0xffff7f33);
  static Color redAccent = const Color(0xfff1a35d);
  static Color grey = const Color(0xff4d4d4d);
}

class Styles {
  // ignore: avoid_positional_boolean_parameters
  static TextStyle text(double size, Color color, bool bold, {double height}) {
    return TextStyle(
      fontSize: size,
      color: color,
      fontWeight: bold ? FontWeight.bold : FontWeight.normal,
      height: height,
      fontFamily: "Poppins",
    );
  }
}
