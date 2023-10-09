import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:rashin_stackvase/core/model/transaction_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransactionController with ChangeNotifier {
  double total = 0.0;
  List<TransactionModel> transactonNotifier = [];

  final transactionDb = Hive.box<TransactionModel>('transactionDb');

  Future<void> addTransaction(TransactionModel value) async {
    final transactionDb = Hive.box<TransactionModel>('transactionDb');
    await transactionDb.add(value);
    transactonNotifier.add(value);
    notifyListeners();
  }

  Future<void> getAllTransaction() async {
    final transactionDb = Hive.box<TransactionModel>('transactionDb');
    transactonNotifier.clear();
    transactonNotifier.addAll(transactionDb.values);
    notifyListeners();
  }

  Future<void> deletTransaction(int index) async {
    final transactionDb = Hive.box<TransactionModel>('transactionDb');
    await transactionDb.deleteAt(index);
    getAllTransaction();
    notifyListeners();
  }

  Future<void> editPlaylist(int index, TransactionModel value) async {
    final transactionDb = Hive.box<TransactionModel>('playlistDb');
    await transactionDb.putAt(index, value);
    getAllTransaction();
    notifyListeners();
  }

  List<double> calculateTotalRupees(Box<TransactionModel> transactionsBox) {
    double totalRupees = 0.0;
    double totalIncome = 0.0;
    double totalExpense = 0.0;
    for (final data in transactionsBox.values) {
      totalRupees += data.rupees!;
      if (data.category == "Income") {
        totalIncome += data.rupees!;
      } else {
        totalExpense += data.rupees!;
      }
    }
    return [totalRupees, totalIncome, totalExpense];
  }

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
