// ignore_for_file: must_be_immutable
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:hive_flutter/adapters.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:rashin_stackvase/core/model/transaction_model.dart';
import 'package:rashin_stackvase/core/provider/db_controller.dart';
import 'package:rashin_stackvase/view/screen/All%20Transaction/all_transaction.dart';
import 'package:rashin_stackvase/view/shared/widget/bottom_sheet.dart';

import '../../shared/widget/flip_card_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  double totalRupees = 0.0;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final transactionProvider = Provider.of<TransactionController>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          "Expense Manager",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                  child: FlipCard(
                    direction: FlipDirection.VERTICAL,
                    front: FrontFlipCard(
                      size: size,
                    ),
                    back: BackFlipCard(size: size),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ValueListenableBuilder(
                    valueListenable: Hive.box<TransactionModel>('transactionDb')
                        .listenable(),
                    builder: (context, value, child) => const Text(
                      "Recent Transactions",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AllTransaction(),
                            ));
                      },
                      child: const Text("View All"))
                ],
              ),
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable:
                      Hive.box<TransactionModel>('transactionDb').listenable(),
                  builder: (context, value, child) {
                    return Hive.box<TransactionModel>('transactionDb').isEmpty
                        ? Lottie.asset(
                            'assets/animations/animation_nodata.json',
                            width: 250,
                            height: 100,
                          )
                        : ListView.builder(
                            itemCount: value.length,
                            itemBuilder: (context, index) {
                              final data = value.values.toList()[index];
                              return Slidable(
                                startActionPane: ActionPane(
                                    motion: const ScrollMotion(),
                                    children: [
                                      SlidableAction(
                                        onPressed: (value) {
                                          transactionProvider
                                              .deletTransaction(index);
                                        },
                                        backgroundColor:
                                            const Color(0xFFFE4A49),
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
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: const BottomSheetWidget(),
              );
            },
          );
        },
        elevation: 5,
        foregroundColor: Colors.orange,
        splashColor: Colors.orange,
        child: const Icon(Icons.add),
      ),
    );
  }
}
