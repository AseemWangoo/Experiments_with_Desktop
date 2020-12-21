import 'package:first_desktop_application/app-level/constants/strings.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color _lightPrimaryColor = Colors.orange;
  static const Color _lightOnPrimaryColor = Colors.black;

  static const Color _darkPrimaryColor = Colors.black;
  static const Color _darkPrimaryAppBarColor = Colors.white;

  static final lightTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      color: _lightPrimaryColor,
      iconTheme: IconThemeData(color: _lightOnPrimaryColor),
    ),
    fontFamily: AppLevelStrings.fontFamily,
    textTheme: const TextTheme(
      bodyText2: TextStyle(color: Colors.black),
    ),
  );

  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: _darkPrimaryColor,
    appBarTheme: const AppBarTheme(
      color: _darkPrimaryAppBarColor,
      iconTheme: IconThemeData(color: _darkPrimaryColor),
    ),
    fontFamily: AppLevelStrings.fontFamily,
    textTheme: const TextTheme(
      bodyText2: TextStyle(color: Colors.white),
    ),
  );
}
