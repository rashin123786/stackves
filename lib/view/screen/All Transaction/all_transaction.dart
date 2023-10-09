import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../core/model/transaction_model.dart';
import '../../../core/provider/db_controller.dart';

class AllTransaction extends StatelessWidget {
  const AllTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    final transactionProvider = Provider.of<TransactionController>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'All Transaction',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable:
            Hive.box<TransactionModel>('transactionDb').listenable(),
        builder: (context, value, child) {
          return Hive.box<TransactionModel>('transactionDb').isEmpty
              ? Center(
                  child: Lottie.asset(
                    'assets/animations/animation_nodata.json',
                    width: double.infinity,
                    height: 300,
                  ),
                )
              : ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    final data = value.values.toList()[index];
                    return Slidable(
                      startActionPane:
                          ActionPane(motion: const ScrollMotion(), children: [
                        SlidableAction(
                          onPressed: (value) {
                            transactionProvider.deletTransaction(index);
                          },
                          backgroundColor: const Color(0xFFFE4A49),
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Delete',
                        ),
                      ]),
                      child: ListTile(
                        title: Text(
                          data.description!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        subtitle: Text(
                          data.category!,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: data.category == 'Income'
                                  ? Colors.green
                                  : Colors.red),
                        ),
                        trailing: Text(
                          '₹${data.rupees}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: data.category == 'Income'
                                  ? Colors.green
                                  : Colors.red),
                        ),
                        leading: data.category == 'Income'
                            ? const Icon(
                                Icons.arrow_circle_up_rounded,
                                color: Colors.green,
                                size: 35,
                              )
                            : const Icon(
                                Icons.arrow_circle_down_rounded,
                                color: Colors.red,
                                size: 35,
                              ),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
