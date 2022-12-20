// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // ignore: prefer_const_literals_to_create_immutables
        actions: [
          IconButton(onPressed:()async{await FirebaseAuth.instance.signOut();
          }, icon: Icon(Icons.login_outlined))
        ],
      ),
      body: Center(
        child: Text("Home Screen"),
      ),
    );
  }
}