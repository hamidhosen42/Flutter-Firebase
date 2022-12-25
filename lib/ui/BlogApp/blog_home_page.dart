// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_firebase/ui/BlogApp/add_post.dart';
class BlogHomePageScreen extends StatefulWidget {
  const BlogHomePageScreen({super.key});

  @override
  State<BlogHomePageScreen> createState() => _BlogHomePageScreenState();
}

class _BlogHomePageScreenState extends State<BlogHomePageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("New Blog"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
             Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>AddBlogPostScreen ()));
          },icon: Icon(Icons.add)),
          SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}