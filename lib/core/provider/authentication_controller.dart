import 'package:flutter/material.dart';

class AuthController with ChangeNotifier {
  String phoneCode = '91';
  void addPhoneCode(String value) {
    phoneCode = value;
    notifyListeners();
  }

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
}
