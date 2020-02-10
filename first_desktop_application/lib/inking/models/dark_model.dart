import 'package:flutter/material.dart';

class TransitionModel with ChangeNotifier {
  bool _darkModeOn = false;

  bool _isFirstLoad = true;

  bool get isFirstLoad => _isFirstLoad;

  bool get currentMode => _darkModeOn;

  void switchMode(bool darkMode) {
    _isFirstLoad = false;
    notifyListeners();

    this._darkModeOn = darkMode;
    notifyListeners();
  }
}
