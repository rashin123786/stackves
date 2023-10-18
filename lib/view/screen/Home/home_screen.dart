// ignore_for_file: must_be_immutable

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:rashin_stackvase/core/provider/home_screen_provider.dart';
import 'package:rashin_stackvase/core/services/home_services.dart';
import 'package:rashin_stackvase/view/screen/All%20Transaction/all_transaction.dart';
import 'package:rashin_stackvase/view/shared/widget/bottom_sheet.dart';

import '../../shared/widget/flip_card_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final homeProvider = Provider.of<HomeScreenProvider>(context);
    homeProvider.getData();
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
                  const Text(
                    "Recent Transactions",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
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
                  child: homeProvider.getDataList.isEmpty
                      ? Lottie.asset(
                          'assets/animations/animation_nodata.json',
                          width: 250,
                          height: 100,
                        )
                      : ListView.builder(
                          itemCount: homeProvider.getDataList.length,
                          itemBuilder: (context, index) {
                            final data = homeProvider.getDataList[index];
                            return Slidable(
                              startActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: (value) async {
                                        await HomeServices()
                                            .deleteTransaction(data.id);
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
                        ))
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
