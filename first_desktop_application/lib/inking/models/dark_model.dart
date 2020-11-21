import 'package:flutter/material.dart';

class TransitionModel with ChangeNotifier {
  bool _darkModeOn = false;

  bool _isFirstLoad = true;

  bool get isFirstLoad => _isFirstLoad;

  bool get currentMode => _darkModeOn;

  // ignore: avoid_positional_boolean_parameters
  void switchMode(bool darkMode) {
    _isFirstLoad = false;
    notifyListeners();

    _darkModeOn = darkMode;
    notifyListeners();
  }
}
