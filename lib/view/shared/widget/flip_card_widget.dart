import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pie_chart/pie_chart.dart';

import 'package:provider/provider.dart';

import '../../../core/model/transaction_model.dart';
import '../../../core/provider/db_controller.dart';
import '../../../utils/constants.dart';

//==========Front Flip Card=========>
class FrontFlipCard extends StatelessWidget {
  const FrontFlipCard({super.key, required this.size});
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionController>(
      builder: (context, transactionController, child) {
        final balance = transactionController.calculateTotalRupees(
          Hive.box<TransactionModel>('transactionDb'),
        );
        dataMap = {"Income": balance[1], "Expense": balance[2]};

        return Card(
          elevation: 5,
          child: Container(
            width: double.infinity,
            height: size.height * 0.3,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  "Current Balance",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "₹${balance[1] - balance[2]}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Card(
                          elevation: 5,
                          shadowColor: Colors.green,
                          child: ListTile(
                            leading: const Icon(
                              Icons.arrow_circle_up_rounded,
                              color: Colors.green,
                            ),
                            title: const Text(
                              "Income",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: Text(
                              "₹${balance[1]}",
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        flex: 1,
                        child: Card(
                          elevation: 5,
                          shadowColor: Colors.red,
                          child: ListTile(
                            leading: const Icon(
                              Icons.arrow_circle_down_rounded,
                              color: Colors.red,
                            ),
                            title: const Text(
                              "Expense",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: Text(
                              "₹${balance[2]}",
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const Text("Tap here for Chart")
              ],
            ),
          ),
        );
      },
    );
  }
}

//==========Black Flip Card=========>

class BackFlipCard extends StatelessWidget {
  const BackFlipCard({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionController>(
      builder: (context, value, child) {
        return Card(
          elevation: 5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: double.infinity,
                height: size.height * 0.3,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(12)),
                child: PieChart(
                  dataMap: dataMap,
                  colorList: const [Colors.green, Colors.red],
                  chartLegendSpacing: 32,
                  chartRadius: MediaQuery.of(context).size.width / 3.2,
                  initialAngleInDegree: 0,
                  chartType: ChartType.ring,
                  ringStrokeWidth: 35,
                ),
              ),
              const Text("Tap here")
            ],
          ),
        );
      },
    );
  }
}
