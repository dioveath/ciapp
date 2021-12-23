import 'package:flutter/material.dart';

class FeedViewMode extends ChangeNotifier {
  bool isDarkMode = false;
  bool isReadMode = false;

  void toggleDarkMode() {
    isDarkMode = !isDarkMode;
    notifyListeners();
  }

  void toggleReadMode() {
    isReadMode = !isReadMode;
    notifyListeners();
  }
}
