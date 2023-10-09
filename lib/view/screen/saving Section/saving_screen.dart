import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:rashin_stackvase/core/provider/db_controller.dart';
import 'package:rashin_stackvase/view/shared/widget/text_field_widget.dart';

import '../../../core/model/transaction_model.dart';

class SavingScreen extends StatelessWidget {
  SavingScreen({super.key});

  final moneyController = TextEditingController();

  final expenseController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Provider.of<TransactionController>(context).loadSavings();
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text("Savings"),
        ),
        body: SafeArea(
          child: ValueListenableBuilder(
              valueListenable:
                  Hive.box<TransactionModel>('transactionDb').listenable(),
              builder: (context, value, child) {
                return Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFieldWidget(
                        widget: const Icon(Icons.attach_money_rounded),
                        textEditingController: moneyController,
                        validator: (p0) =>
                            p0!.isEmpty ? 'please enter salary' : null,
                        keyboardType: TextInputType.phone,
                        label: 'Enter Your Salary',
                      ),
                      TextFieldWidget(
                        widget: const Icon(Icons.money_off_csred_rounded),
                        textEditingController: expenseController,
                        validator: (p0) =>
                            p0!.isEmpty ? 'please enter Expense' : null,
                        keyboardType: TextInputType.phone,
                        label: 'Enter Your Expense',
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Consumer<TransactionController>(
                          builder: (context, value, child) {
                        return Text(
                          "Saving :₹${value.savings}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        );
                      })
                    ],
                  ),
                );
              }),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  final data = ((double.tryParse(moneyController.text) ?? 0) -
                      (double.tryParse(expenseController.text) ?? 0));
                  await Provider.of<TransactionController>(context,
                          listen: false)
                      .updateSavings(data);
                  moneyController.clear();
                  expenseController.clear();
                }
              },
              child: const Text('Submit')),
        ));
  }
}
