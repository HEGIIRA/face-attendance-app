import 'package:flutter/material.dart';

class DateProvider extends ChangeNotifier {
  DateTime _selectedDate = DateTime.now();

  DateTime get selectedDate => _selectedDate;

  void nextDate() {
    _selectedDate = _selectedDate.add(Duration(days: 1));
    notifyListeners();
  }

  void previousDate() {
    _selectedDate = _selectedDate.subtract(Duration(days: 1));
    notifyListeners();
  }

  void setDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }
}
