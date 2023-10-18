import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:rashin_stackvase/core/model/transaction.dart';

class HomeServices {
  Future addTransaction(
      BuildContext context, TransactionModels transactionModels) async {
    await FirebaseFirestore.instance
        .collection('transactions')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('yourTransactions')
        .add({
      "id": '1',
      "category": transactionModels.category,
      "date": transactionModels.date,
      "description": transactionModels.description,
      "rupees": transactionModels.rupees,
    }).then((value) {
      FirebaseFirestore.instance
          .collection('transactions')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('yourTransactions')
          .doc(value.id)
          .update({
        "id": value.id,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Created Successfully :)'),
        ),
      );
    });
  }

  deleteTransaction(id) async {
    await FirebaseFirestore.instance
        .collection('transactions')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('yourTransactions')
        .doc(id)
        .delete();
  }

  final CollectionReference transactionCollect = FirebaseFirestore.instance
      .collection('transactions')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('yourTransactions');
  Stream<List<TransactionModels>> getAllTransactions() {
    return transactionCollect.snapshots().map((event) {
      return event.docs.map((e) {
        return TransactionModels.fromJson(e.data() as Map<String, dynamic>);
      }).toList();
    });
  }
}
