import 'package:flutter/material.dart';

class ThemeSwitcher with ChangeNotifier {
  bool _darkModeOn = false;

  String currentTheme() => _darkModeOn == true ? 'Dark Mode' : 'Light Mode';

  bool darkModeOn() => _darkModeOn;

  void turnOnDarkMode(bool darkMode) {
    this._darkModeOn = darkMode;
    notifyListeners();
  }
}
