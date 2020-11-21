import 'package:flutter/material.dart';

class ThemeSwitcher with ChangeNotifier {
  bool _darkModeOn = false;

  String currentTheme() => _darkModeOn == true ? 'Dark Mode' : 'Light Mode';

  bool darkModeOn() => _darkModeOn;

  // ignore: avoid_positional_boolean_parameters
  void turnOnDarkMode(bool darkMode) {
    _darkModeOn = darkMode;
    notifyListeners();
  }
}
