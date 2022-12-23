// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_firebase/ui/HomePage/HomePost.dart';
import 'package:flutter_firebase/ui/firestore/firestore_list_screen.dart';
import 'package:flutter_firebase/widgets/round_button.dart';

class HomeScreen extends StatelessWidget {
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
            RoundButton("RealTime Data", loading, () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomePost()));
            }),
            SizedBox(
              height: 20,
            ),
            RoundButton("FireStore Data", loading, () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FireStoreScreen()));
            }),
          ],
        ),
      ),
    ));
  }
}
