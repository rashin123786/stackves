import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SavingController with ChangeNotifier {
  double savings = 0.0;
  updateSavings(double newSavings) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('Key', newSavings);
    await loadSavings();
    notifyListeners();
  }

  loadSavings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    savings = prefs.getDouble('Key') ?? 0.0;
    log(savings.toString());
    notifyListeners();
  }
}
