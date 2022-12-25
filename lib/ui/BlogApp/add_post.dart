// ignore_for_file: prefer_const_constructors, unused_field

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_firebase/widgets/round_button.dart';

class AddBlogPostScreen extends StatefulWidget {
  const AddBlogPostScreen({super.key});

  @override
  State<AddBlogPostScreen> createState() => _AddBlogPostScreenState();
}

class _AddBlogPostScreenState extends State<AddBlogPostScreen> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  File? _image;

  @override
  Widget build(BuildContext context) {
    final h=MediaQuery.of(context).size.height;
    final w=MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Blogs"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          child: Column(
            children: [
              Center(
                child: InkWell(
                  onTap: () {
                    // getImageGally();
                  },
                  child: Container(
                    height: h*0.2,
                    width: w*1,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey.shade400)),
                    child: _image != null
                        ? Image.file(_image!.absolute)
                        : Center(child: Icon(Icons.camera_alt)),
                  ),
                ),
              ),
              SizedBox(height: h/20,),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      maxLines: 2,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter title";
                        } else {
                          return null;
                        }
                      },
                      controller: _titleController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Title",
                         labelStyle: TextStyle(fontSize: 20),
                        hintText: 'Enter Post Title',
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 20.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade400, width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade400, width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(minLines: 3,
                      maxLines: 5,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter description";
                        } else {
                          return null;
                        }
                      },
                      controller: _descriptionController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Description",
                        labelStyle: TextStyle(fontSize: 20),
                        hintText: 'Enter Post Description',
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 20.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade400, width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade400, width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: h/20,),
              RoundButton("Upload", loading, (){})
            ],
          ),
        ),
      ),
    );
  }
}