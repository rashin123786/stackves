import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rashin_stackvase/core/provider/home_screen_provider.dart';
import 'package:rashin_stackvase/view/screen/Home/home_screen.dart';
import 'package:rashin_stackvase/view/screen/saving%20Section/saving_screen.dart';

class BottomNavWidget extends StatelessWidget {
  BottomNavWidget({super.key});
  final int _currentSelectedIndex = 0;

  final pages = [const HomeScreen(), SavingScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<HomeScreenProvider>(
        builder: (context, value, child) {
          return PageView(
            children: [pages[value.currentSelectedIndex]],
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentSelectedIndex,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.amber,
        onTap: (value) {
          Provider.of<HomeScreenProvider>(context, listen: false)
              .bottomSwitch(value);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.graphic_eq), label: 'Saving')
        ],
      ),
    );
  }
}
