import 'package:flutter/material.dart';

class CustomTheme with ChangeNotifier {
  static bool _isDark = false;

  ThemeMode currentTheme() {
    return _isDark ? ThemeMode.dark : ThemeMode.light;
  }

  void switchTheme() {
    _isDark = !_isDark;
    notifyListeners();
  }
}

ThemeData greenLightTheme() => ThemeData(
      fontFamily: 'OpenSans',
      brightness: Brightness.light,
      primaryColor: Colors.green,
      backgroundColor: Colors.white,
    );

ThemeData pirpleDarkTheme() => ThemeData(
      fontFamily: 'OpenSans',
      brightness: Brightness.light,
      primaryColor: Colors.green,
      backgroundColor: Colors.white,
    );
