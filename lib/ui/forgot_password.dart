// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_final_fields

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_loading_animation_kit/flutter_loading_animation_kit.dart';

import '../firbase/auth.dart';
import '../utils/utils.dart';
import '../widgets/round_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  final auth = FirebaseAuth.instance;

  // @override
  // void dispose() {
  //   super.dispose;
  //   _emailController.dispose();
  //   _passwordController.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: SplashServices.appBarColor,
        automaticallyImplyLeading: true,
        title: Text(
          "Forgot Password",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 80,
              ),
              FourCirclePulse(
                circleColor: Colors.deepPurple, //The color of the circles
                dimension: 100.0, // The size of the widget.
                turns: 5, //Turns in each loop
                loopDuration:
                    const Duration(seconds: 5), // Duration of each loop
                curve: Curves.linear, //Curve of the animation
              ),
              SizedBox(
                height: 70.0,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      onChanged: (value) {
                        //Do something with the user input.
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Email";
                        } else {
                          return null;
                        }
                      },
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: 'Enter your email',
                        suffixIcon: Icon(Icons.email_outlined),
                        prefixIcon: Icon(Icons.person),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 20.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.green, width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.green, width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              RoundButton("Forgot", loading, () {
                if (_formKey.currentState!.validate()) {
                  auth
                      .sendPasswordResetEmail(email: _emailController.text)
                      .then((value) {
                    Utils().toastMessage(
                        "We have sent you email to recover password, please check email");
                        Navigator.pop(context);
                  }).onError((error, stackTrace) {
                    Utils().toastMessage(error.toString());
                  });
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
