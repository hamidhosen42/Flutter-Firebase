// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_firebase/ui/BlogApp-RealTime/blog_home_page.dart';
import 'package:flutter_firebase/ui/real_time_store/real_time_screen.dart';
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
             SizedBox(
              height: 20,
            ),
            RoundButton("Blog App", loading, () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BlogHomePageScreen()));
            }),
          ],
        ),
      ),
    ));
  }
}
