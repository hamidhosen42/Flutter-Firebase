// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations, avoid_unnecessary_containers

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_firebase/ui/BlogApp/add_blog_post.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';

import '../../utils/utils.dart';
import '../auth/login_screen.dart';

class BlogHomePageScreen extends StatefulWidget {
  const BlogHomePageScreen({super.key});

  @override
  State<BlogHomePageScreen> createState() => _BlogHomePageScreenState();
}

class _BlogHomePageScreenState extends State<BlogHomePageScreen> {
  final searchFilter = TextEditingController();
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final _postEditController = TextEditingController();
  final _postEditSubController = TextEditingController();
  final databaseRef = FirebaseDatabase.instance.ref('Blog');

  File? _image;
  final _picker = ImagePicker();

  Future getImageGally() async {
    final pickedFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print("No Image Picked");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: ()async{
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("New Blog"),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddBlogPostScreen()));
                },
                icon: Icon(Icons.add)),
            IconButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut().then((value) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  }).onError((error, stackTrace) {
                    Utils().toastMessage(error.toString());
                  });
                },
                icon: Icon(Icons.login_outlined)),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextFormField(
                  onChanged: (String value) {
                    setState(() {});
                  },
                  controller: searchFilter,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Search',
                    // suffixIcon: Icon(Icons.search),
                    prefixIcon: Icon(Icons.search),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.deepPurple, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.deepPurple, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: FirebaseAnimatedList(
                  query: databaseRef, defaultChild: Text("Loading"),
                  // reverse: _anchorToBottom,
                  itemBuilder: (context, snapshot, animation, index) {
                    final id = snapshot.child('id').value.toString();
                    final image = snapshot.child('image').value.toString();
                    final time = snapshot.child("time").value.toString();
                    final title = snapshot.child("title").value.toString();
                    final description =
                        snapshot.child("description").value.toString();
                    final email = snapshot.child("email").value.toString();
                    final uid = snapshot.child('uid').value.toString();
    
                    if (searchFilter.text.isEmpty) {
                      return Container(
                        decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: FadeInImage.assetNetwork(
                                fit: BoxFit.fill,
                                placeholder: "",
                                image: image,
                                height: h * 0.25,
                                width: w * 1,
                              ),
                            ),
                            SizedBox(
                              height: h * 0.01,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: Text(title,
                                  style: TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.bold)),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: Text(
                                description,
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.normal),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                            SizedBox(
                              height: h * 0.01,
                            ),
                          ],
                        ),
                      );
                    } else if (title.toLowerCase().contains(
                        searchFilter.text.toLowerCase().toLowerCase())) {
                      return SizeTransition(
                        sizeFactor: animation,
                        child: ListTile(
                          iconColor: Colors.red,
                          title:
                              Text('${snapshot.child('title').value.toString()}'),
                          // subtitle:
                          //     Text(snapshot.child("description").value.toString()),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}