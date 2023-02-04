// ignore_for_file: prefer_const_constructors, override_on_non_overriding_member, unused_field, prefer_final_fields, use_key_in_widget_constructors, body_might_complete_normally_nullable, unused_element, dead_code

import 'package:flutter/material.dart';
import 'package:flutter_firebase/firbase/auth.dart';
import 'package:flutter_firebase/ui/auth/login_screen.dart';
import 'package:flutter_firebase/utils/utils.dart';
import 'package:flutter_firebase/widgets/round_button.dart';
import 'package:flutter_loading_animation_kit/flutter_loading_animation_kit.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool loading = false;

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
        // automaticallyImplyLeading: false,
        title: Text(
          "Create Account",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        // leading: IconButton(
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        //   icon: Icon(Icons.arrow_back),
        // ),
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
                turns: 10, //Turns in each loop
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
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      onChanged: (value) {
                        //Do something with the user input.
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Password";
                        } else {
                          return null;
                        }
                      },
                      controller: _passwordController,
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Enter your password',
                        suffixIcon: Icon(Icons.remove_red_eye_sharp),
                        prefixIcon: Icon(Icons.lock_open_outlined),
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
              RoundButton("SignUp", loading, () {
                if (_formKey.currentState!.validate()) {
                  signUp();
                }
              }),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?"),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      },
                      child: Text("Login"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void signUp() {
    setState(() {
      loading = true;
    });
    Auth()
        .registration(_emailController.text, _passwordController.text, context)
        .then((value) {
      setState(() {
        loading=false;
      });
    }).onError((error, stackTrace) {
      Utils().toastMessage(error.toString());
      setState(() {
        loading =false;
      });
    });
  }
}