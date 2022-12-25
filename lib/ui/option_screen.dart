// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_firebase/ui/auth/login_screen.dart';
import 'package:flutter_firebase/ui/auth/signup_screen.dart';
import 'package:flutter_firebase/widgets/round_button.dart';
import 'package:flutter_loading_animation_kit/flutter_loading_animation_kit.dart';

class OptionScreen extends StatelessWidget {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
               SizedBox(
                  height: 180,
                ),
              FourCirclePulse(
                  circleColor: Colors.deepPurple, //The color of the circles
                  dimension: 100.0, // The size of the widget.
                  turns: 10, //Turns in each loop
                  loopDuration:
                      const Duration(seconds: 5), // Duration of each loop
                  curve: Curves.linear, //Curve of the animation
                ),
                SizedBox(
                  height: 100,
                ),
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
      ),
    ));
  }
}