import 'package:chefaa/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProviederData extends ChangeNotifier {
  ThemeData _themeData = darkMode ? ThemeData.dark() : ThemeData.light();
  getTheme() {
    return _themeData;
  }

  setTheme(ThemeData theme) {
    _themeData = theme;
    notifyListeners();
  }
}
