// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_firebase/firebase_services/splash_services.dart';
import 'package:flutter_loading_animation_kit/flutter_loading_animation_kit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices services = SplashServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    services.isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FourCirclePulse(
          circleColor: Colors.deepPurple, //The color of the circles
          dimension: 100.0, // The size of the widget.
          turns: 5, //Turns in each loop
          loopDuration: const Duration(seconds: 5), // Duration of each loop
          curve: Curves.linear, //Curve of the animation
        ),
      ),
    );
  }
}