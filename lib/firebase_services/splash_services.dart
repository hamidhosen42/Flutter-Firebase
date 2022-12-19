// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/ui/auth/login_screen.dart';

class SplashServices {

  static Color appBarColor = Colors.green;
  void isLogin(BuildContext context) {
    Timer(
        Duration(seconds: 3),
        () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginScreen())));
  }
  
}
