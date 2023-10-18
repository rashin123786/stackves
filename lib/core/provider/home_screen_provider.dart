import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rashin_stackvase/core/model/transaction.dart';

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

  List<TransactionModels> dataList = [];
  void getData() async {
    List<TransactionModels> newList = [];
    final value = await FirebaseFirestore.instance
        .collection('transactions')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('yourTransactions')
        .get();
    for (var element in value.docs) {
      TransactionModels transactionModels = TransactionModels(
          category: element.get('category'),
          date: element.get('date'),
          description: element.get('description'),
          id: element.get('id'),
          rupees: element.get('rupees'));
      newList.add(transactionModels);
    }
    dataList = newList;
    notifyListeners();
  }

  List<TransactionModels> get getDataList {
    return dataList;
  }

  double total = 0;
  double income = 0;
  double expense = 0;
  getTotal() {
    double total = 0.0;
    double income = 0.0;
    double expense = 0.0;
    for (var element in dataList) {
      if (element.category == 'Income') {
        income += element.rupees!;
      } else {
        expense += element.rupees!;
      }
      total += element.rupees!;
    }
    return [total, income, expense];
  }
}
