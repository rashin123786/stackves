import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreenProvider extends ChangeNotifier {
  int _selectedValue = 0;

  int get selectedValue => _selectedValue;

  set selectedValue(int value) {
    _selectedValue = value;
    notifyListeners();
  }

  DateTime _selectedDate = DateTime.now();

  DateTime get selectedDate => _selectedDate;

  void setSelectedDate(DateTime newDate) {
    _selectedDate = newDate;
    notifyListeners();
  }

  String get formattedDate => DateFormat('d MMM y').format(_selectedDate);

  int currentSelectedIndex = 0;

  void bottomSwitch(index) {
    currentSelectedIndex = index;
    notifyListeners();
  }
}
