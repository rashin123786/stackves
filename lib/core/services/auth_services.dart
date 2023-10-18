import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rashin_stackvase/view/screen/Authentication/otp_screen.dart';
import 'package:rashin_stackvase/view/shared/pages/bottom_nav.dart';

import '../provider/authentication_controller.dart';

class AuthServices {
  final _auth = FirebaseAuth.instance;
  String smsCode = '';
  Future registerUser(BuildContext context, String number) async {
    final authProvider = Provider.of<AuthController>(context, listen: false);

    await _auth.verifyPhoneNumber(
      phoneNumber: number,
      verificationCompleted: (phoneAuthCredential) async {
        await _auth.signInWithCredential(phoneAuthCredential);
      },
      verificationFailed: (error) {
        authProvider.setLoading(false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$error'),
          ),
        );
        log(error.toString());
      },
      codeSent: (verificationId, forceResendingToken) {
        authProvider.setLoading(false);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  OtpScreen(number: number, verificationId: verificationId),
            ));
      },
      codeAutoRetrievalTimeout: (verificationId) {},
    );
  }

  signInPhoneNumber(
      BuildContext context, String otp, String verificationId) async {
    final authProvider = Provider.of<AuthController>(context, listen: false);
    FirebaseAuth auth = FirebaseAuth.instance;
    smsCode = otp;
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);
    await auth.signInWithCredential(phoneAuthCredential).then((value) {
      authProvider.setLoading(false);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BottomNavWidget(),
          ));
    }).catchError((error) {
      authProvider.setLoading(false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Enter the correct verification code again.'),
        ),
      );
    });
  }
}
