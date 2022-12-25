// ignore_for_file: prefer_const_constructors, unused_field, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_firebase/widgets/round_button.dart';
import 'package:image_picker/image_picker.dart';

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
  final _picker = ImagePicker();

    Future getImageGallery() async {
    final pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print("No Image Picked");
      }
    });
  }

    Future getCamraImage() async {
    final pickedFile =
        await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print("No Image Picked");
      }
    });
  }

  void dialog(contex){
    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0)
        ),
        content: Container(
          height: 120,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: (){
                  getCamraImage();
                  Navigator.pop(context);
                },
                child: ListTile(
                  leading: Icon(Icons.camera),
                  title: Text("Camera"),
                ),
              ),
              InkWell(
                onTap: (){
                  getImageGallery();
                   Navigator.pop(context);
                },
                child: ListTile(
                  leading: Icon(Icons.photo_library),
                  title: Text("Gallery"),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

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
                     dialog(context);
                  },
                  child: Container(
                    height: h*0.3,
                    width: w*1,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey.shade400)),
                    child: _image != null
                        ? ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.file(_image!.absolute,fit: BoxFit.fill,))
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