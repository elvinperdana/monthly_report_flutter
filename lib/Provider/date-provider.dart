import 'package:flutter/material.dart';

class DateProvider with ChangeNotifier {
  int _month = DateTime.now().month;
  int _year = DateTime.now().year;

  int get month => _month;

  int get year => _year;

  void updateDate(int month, int year) {
    _month = month;
    _year = year;
    notifyListeners();
  }
}
