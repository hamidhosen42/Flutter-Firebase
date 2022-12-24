// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_firebase/ui/auth/login_screen.dart';
import 'package:flutter_firebase/ui/auth/signup_screen.dart';
import 'package:flutter_firebase/widgets/round_button.dart';

class OptionScreen extends StatelessWidget {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RoundButton("Login", loading, () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            }),
            SizedBox(
              height: 20,
            ),
            RoundButton("Register", loading, () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SignUpScreen()));
            }),
          ],
        ),
      ),
    ));
  }
}