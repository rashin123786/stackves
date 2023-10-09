import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rashin_stackvase/core/model/transaction_model.dart';
import 'package:rashin_stackvase/core/provider/db_controller.dart';
import 'package:rashin_stackvase/view/shared/widget/text_field_widget.dart';
import '../../../core/provider/home_screen_provider.dart';

class BottomSheetWidget extends StatefulWidget {
  const BottomSheetWidget({super.key});

  @override
  State<BottomSheetWidget> createState() => _BottomSheetWidgetState();
}

DateTime dateTime = DateTime.now();
String selectedOption = 'Income';

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  String formattedDate = DateFormat('d MMM y').format(dateTime);
  final rupeeController = TextEditingController();
  final descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final dateProvider = Provider.of<HomeScreenProvider>(context);
    final transactionProvider = Provider.of<TransactionController>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: SizedBox(
          height: 500,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Consumer<HomeScreenProvider>(
                      builder: (context, homeProvider, _) => Card(
                        elevation: 5,
                        shadowColor: Colors.orange,
                        child: RadioMenuButton(
                          value: 0,
                          groupValue: homeProvider.selectedValue,
                          onChanged: (value) {
                            homeProvider.selectedValue = value!;
                            selectedOption =
                                (value == 0 ? 'Income' : 'Expense');
                          },
                          child: const Text(
                            'Income',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    Consumer<HomeScreenProvider>(
                      builder: (context, radioValueNotifier, _) => Card(
                        shadowColor: Colors.red,
                        elevation: 5,
                        child: RadioMenuButton(
                          value: 1,
                          groupValue: radioValueNotifier.selectedValue,
                          onChanged: (value) {
                            radioValueNotifier.selectedValue = value!;
                            selectedOption =
                                (value == 0 ? 'Income' : 'Expense');
                          },
                          child: const Text('Expense',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                TextFieldWidget(
                    keyboardType: TextInputType.phone,
                    validator: (p0) => p0!.isEmpty ? 'Enter an amount' : null,
                    widget: const Icon(Icons.attach_money),
                    textEditingController: rupeeController),
                TextFieldWidget(
                  keyboardType: TextInputType.text,
                  validator: (p1) =>
                      p1!.isEmpty ? 'please enter Description' : null,
                  widget: const Icon(Icons.list_alt_outlined),
                  textEditingController: descriptionController,
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      ElevatedButton.icon(
                          onPressed: () {
                            showDate(context, dateProvider);
                          },
                          style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(),
                          ),
                          icon: const Icon(Icons.date_range),
                          label: const Text('Choose Date')),
                      const SizedBox(
                        width: 15,
                      ),
                      Consumer<HomeScreenProvider>(
                          builder: (context, value, child) => Text(
                                value.formattedDate,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ))
                    ],
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          TransactionModel transactionModel = TransactionModel(
                            category: selectedOption,
                            date: formattedDate,
                            rupees: double.tryParse(rupeeController.text) ?? 0,
                            description: descriptionController.text,
                          );

                          transactionProvider
                              .addTransaction(transactionModel)
                              .then((value) => Navigator.pop(context));
                        }
                      },
                      child: const Text('Submit')),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showDate(context, HomeScreenProvider dateProvider) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: dateProvider.selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      dateProvider.setSelectedDate(selectedDate);
    }
  }
}
