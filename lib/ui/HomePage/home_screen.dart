// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, unused_local_variable, unnecessary_string_interpolations

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/ui/HomePage/add_post.dart';
import 'package:flutter_firebase/ui/auth/login_screen.dart';
import 'package:flutter_firebase/utils/utils.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final databaseRef = FirebaseDatabase.instance.ref('Post');

  final searchFilter = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // ignore: prefer_const_literals_to_create_immutables
        automaticallyImplyLeading: false,
        title: Text("Post"),
        centerTitle: true,
        actions: [
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
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              onChanged: (String value) {
                setState(() {
                  
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Enter Password";
                } else {
                  return null;
                }
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
                  borderSide: BorderSide(color: Colors.deepPurple, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepPurple, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
              ),
            ),
          ),

          // !animated realtime data-------------------------
          Expanded(
            child: FirebaseAnimatedList(
              query: databaseRef, defaultChild: Text("Loading"),
              // reverse: _anchorToBottom,
              itemBuilder: (context, snapshot, animation, index) {
                final title = snapshot.child("title").value.toString();

                if (searchFilter.text.isEmpty) {
                  return SizeTransition(
                    sizeFactor: animation,
                    child: ListTile(
                      iconColor: Colors.red,
                      trailing: IconButton(
                        // onPressed: () => _deleteMessage(snapshot),
                        onPressed: () {},
                        icon: const Icon(Icons.delete),
                      ),
                      title:
                          Text('${snapshot.child('title').value.toString()}'),
                      subtitle: Text(snapshot.child("id").value.toString()),
                    ),
                  );
                }
                else if(title.toLowerCase().contains(searchFilter.text.toLowerCase().toLowerCase()))
                {
                  return SizeTransition(
                  sizeFactor: animation,
                  child: ListTile(
                    iconColor: Colors.red,
                    trailing: IconButton(
                      // onPressed: () => _deleteMessage(snapshot),
                      onPressed: () {},
                      icon: const Icon(Icons.delete),
                    ),
                    title: Text('${snapshot.child('title').value.toString()}'),
                    subtitle: Text(snapshot.child("id").value.toString()),
                  ),
                );
                }
                else
                {
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddPostScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}




          // Expanded(
          //     child: StreamBuilder(
          //   stream: databaseRef.onValue,
          //   builder: ((context, AsyncSnapshot<DatabaseEvent> snapshot) {
          //     if (!snapshot.hasData) {
          //       return CircularProgressIndicator();
          //     } else {
          //       Map<dynamic, dynamic> map =
          //           snapshot.data!.snapshot.value as dynamic;
          //       List<dynamic> list = [];
          //       list.clear();
          //       list = map.values.toList();

          //       return ListView.builder(
          //         itemCount: snapshot.data!.snapshot.children.length,
          //         itemBuilder: ((context, index) {
          //           return ListTile(
          //             title: Text(list[index]['title']),
          //             subtitle: Text(list[index]['id']),
          //           );
          //         }),
          //       );
          //     }
          //   }),
          // )),