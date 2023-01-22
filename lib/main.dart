import 'package:flutter/material.dart';
import 'package:test_app/otp.dart';
import 'package:test_app/phone.dart';
import 'package:test_app/home.dart';
import 'package:test_app/email.dart';
import 'package:test_app/emailotp.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
    initialRoute: 'phone',
    routes: {
      'emailotp': (context) => EmailOTP(""),
      'email': (context) => EmailWidget(),
      'phone': (context) => Phone(),
      'otp': (context) => OTP(),
      'home':(context) => Home(),
    }
));
}



