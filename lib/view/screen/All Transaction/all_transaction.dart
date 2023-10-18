import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../../core/provider/home_screen_provider.dart';
import '../../../core/services/home_services.dart';

class AllTransaction extends StatelessWidget {
  const AllTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeScreenProvider>(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'All Transaction',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: homeProvider.getDataList.isEmpty
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
                    startActionPane:
                        ActionPane(motion: const ScrollMotion(), children: [
                      SlidableAction(
                        onPressed: (value) async {
                          await HomeServices().deleteTransaction(data.id);
                        },
                        backgroundColor: const Color(0xFFFE4A49),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                    ]),
                    child: GestureDetector(
                      onTap: () {},
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
                    ),
                  );
                },
              ));
  }
}
