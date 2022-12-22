// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/ui/auth/login_screen.dart';
import 'package:flutter_firebase/ui/HomePage/home_screen.dart';

class SplashServices {
  static Color appBarColor = Colors.green;

  void isLogin(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Timer(
          Duration(seconds: 3),
          () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomeScreen())));
    } else {
      Timer(
          Duration(seconds: 3),
          () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginScreen())));
    }
  }
}