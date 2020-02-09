import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color _lightPrimaryColor = Colors.orange;
  static const Color _lightOnPrimaryColor = Colors.black;

  static const Color _darkPrimaryColor = Colors.black;
  static const Color _darkPrimaryAppBarColor = Colors.white;

  static final lightTheme = ThemeData(
    appBarTheme: AppBarTheme(
      color: _lightPrimaryColor,
      iconTheme: IconThemeData(color: _lightOnPrimaryColor),
    ),
    fontFamily: 'Roboto',
    textTheme: TextTheme(
      bodyText2: TextStyle(color: Colors.black),
    ),
  );

  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: _darkPrimaryColor,
    appBarTheme: AppBarTheme(
      color: _darkPrimaryAppBarColor,
      iconTheme: IconThemeData(color: _darkPrimaryColor),
    ),
    fontFamily: 'Roboto',
    textTheme: TextTheme(
      bodyText2: TextStyle(color: Colors.white),
    ),
  );
}
