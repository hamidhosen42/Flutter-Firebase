// ignore_for_file: prefer_const_constructors, unused_field, unused_local_variable

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/utils/utils.dart';

import '../../widgets/round_button.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final _postController = TextEditingController();
  final _postSubController = TextEditingController();

  final databaseRef = FirebaseDatabase.instance.ref('Post');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Post"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    maxLines: 2,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Text";
                      } else {
                        return null;
                      }
                    },
                    controller: _postController,
                    decoration: InputDecoration(
                      hintText: 'What is in your mind?',
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
                  TextFormField(
                    maxLines: 4,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Text";
                      } else {
                        return null;
                      }
                    },
                    controller: _postSubController,
                    decoration: InputDecoration(
                      hintText: 'Description',
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
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            RoundButton("Add", loading, () {
              if (_formKey.currentState!.validate()) {
                setState(() {
                  loading = true;
                });

                String id = DateTime.now().microsecondsSinceEpoch.toString();

                databaseRef.child(id).set({
                  'id': id,
                  'title': _postController.text,
                  'subtitle': _postSubController.text,
                }).then((value) {
                  Utils().toastMessage("Post Added");
                  setState(() {
                    loading = false;
                  });
                }).onError((error, stackTrace) {
                  Utils().toastMessage(error.toString());
                  setState(() {
                    loading = false;
                  });
                });
              }
            }),
          ],
        ),
      ),
    );
  }
}