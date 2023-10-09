// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:rashin_stackvase/view/shared/pages/bottom_nav.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    navigateToHome();
    super.initState();
  }

  navigateToHome() async {
    await Future.delayed(const Duration(milliseconds: 2500), () {});
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BottomNavWidget(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
              child: Text(
                'Never spend your money\nbefore you have it',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Color.fromRGBO(55, 55, 55, 1),
                ),
              ),
            ),
            Lottie.asset('assets/animations/animation_logo.json'),
          ],
        ),
      ),
    );
  }
}
