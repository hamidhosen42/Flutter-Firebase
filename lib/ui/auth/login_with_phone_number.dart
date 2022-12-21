// ignore_for_file: prefer_const_constructors, override_on_non_overriding_member, unused_field, prefer_final_fields, use_key_in_widget_constructors, body_might_complete_normally_nullable, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, avoid_single_cascade_in_expression_statements, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/ui/auth/signup_screen.dart';
import 'package:flutter_firebase/ui/auth/verify_code.dart';
import 'package:flutter_firebase/utils/utils.dart';
import 'package:flutter_firebase/widgets/round_button.dart';
import 'package:flutter_loading_animation_kit/flutter_loading_animation_kit.dart';

class LoginWithPhoneNumber extends StatefulWidget {
  @override
  State<LoginWithPhoneNumber> createState() => _LoginWithPhoneNumberState();
}

class _LoginWithPhoneNumberState extends State<LoginWithPhoneNumber> {
  final _formKey = GlobalKey<FormState>();
  final _phoneNumbercontroller = TextEditingController();
  bool loading = false;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: SplashServices.appBarColor,
        // automaticallyImplyLeading: false,
        title: Text(
          "Login With Phone",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: 80,
            ),
            FourCirclePulse(
              circleColor: Colors.deepPurple, //The color of the circles
              dimension: 100.0, // The size of the widget.
              turns: 5, //Turns in each loop
              loopDuration: const Duration(seconds: 5), // Duration of each loop
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
                        return "Enter PhoneNumber";
                      } else {
                        return null;
                      }
                    },
                    controller: _phoneNumbercontroller,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: '+088 123 2422 323',
                      suffixIcon: Icon(Icons.call),
                      prefixIcon: Icon(Icons.person),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  RoundButton("Login", loading, () {
                    if (_formKey.currentState!.validate()) {
                      auth
                        ..verifyPhoneNumber(
                          phoneNumber: _phoneNumbercontroller.text,
                          verificationCompleted:
                              (PhoneAuthCredential credential) {},
                          verificationFailed: (e) {
                            Utils().toastMessage(e.toString());
                          },
                          timeout: const Duration(seconds: 60),
                          codeSent: (String verificationId, int? resendToken) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => VerifyCodeScreen()));
                          },
                          codeAutoRetrievalTimeout: (verificationId) {
                            Utils().toastMessage(verificationId.toString());
                          },
                        );
                    }
                  }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?"),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpScreen()));
                          },
                          child: Text("Sign Up"))
                    ],
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  // void login() {
  //   setState(() {
  //     loading = true;
  //   });
  //   Auth()
  //       .login(_emailController.text, _passwordController.text, context)
  //       .onError((error, stackTrace) => Utils().toastMessage(error.toString()))
  //       .then((value) {
  //     final user = FirebaseAuth.instance.currentUser;
  //     final x = user?.email;
  //     Utils().toastMessage(x.toString());
  //     loading = false;
  //   }).onError((error, stackTrace) {
  //     debugPrint(error.toString());
  //     Utils().toastMessage(error.toString());
  //     setState(() {
  //       loading = false;
  //     });
  //   });
  // }
}