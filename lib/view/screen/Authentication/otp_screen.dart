import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rashin_stackvase/core/services/auth_services.dart';
import 'package:rashin_stackvase/view/shared/widget/otp_widget.dart';

import '../../../core/provider/authentication_controller.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({super.key, required this.number, required this.verificationId});
  final String number;
  final String verificationId;
  final firstcontroller = TextEditingController();
  final secondcontroller = TextEditingController();

  final thirdcontroller = TextEditingController();
  final forthcontroller = TextEditingController();
  final fifthcontroller = TextEditingController();
  final sixthcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'OTP Verification',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Enter the OTP sent to $number',
              style: const TextStyle(),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                otpRow(controller: firstcontroller),
                otpRow(controller: secondcontroller),
                otpRow(controller: thirdcontroller),
                otpRow(controller: forthcontroller),
                otpRow(controller: fifthcontroller),
                otpRow(controller: sixthcontroller),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Consumer<AuthController>(
              builder: (context, value, child) => ElevatedButton(
                onPressed: () async {
                  String otpText = firstcontroller.text +
                      secondcontroller.text +
                      thirdcontroller.text +
                      forthcontroller.text +
                      fifthcontroller.text +
                      sixthcontroller.text;

                  if (otpText.length != 6) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please enter a 6-digit OTP.'),
                      ),
                    );
                  } else {
                    value.setLoading(true);

                    await AuthServices()
                        .signInPhoneNumber(context, otpText, verificationId);
                  }
                },
                child: value.isLoading == true
                    ? const Text('Loading....')
                    : const Text('Confirm'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
