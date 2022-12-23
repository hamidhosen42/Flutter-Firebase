// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, unused_local_variable, unnecessary_string_interpolations, avoid_unnecessary_containers

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/ui/HomePage/add_post.dart';
import 'package:flutter_firebase/ui/auth/login_screen.dart';
import 'package:flutter_firebase/utils/utils.dart';

import '../../widgets/round_button.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final searchFilter = TextEditingController();
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final _postEditController = TextEditingController();
  final _postEditSubController = TextEditingController();

  final databaseRef = FirebaseDatabase.instance.ref('Post');

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
                setState(() {});
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
          SizedBox(
            height: 10,
          ),

          // !animated realtime data-------------------------
          Expanded(
            child: FirebaseAnimatedList(
              query: databaseRef, defaultChild: Text("Loading"),
              // reverse: _anchorToBottom,
              itemBuilder: (context, snapshot, animation, index) {
                final title = snapshot.child("title").value.toString();
                final subtitle = snapshot.child("subtitle").value.toString();
                final id = snapshot.child('id').value.toString();

                if (searchFilter.text.isEmpty) {
                  return SizeTransition(
                    sizeFactor: animation,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: ListTile(
                        trailing: PopupMenuButton(
                            icon: Icon(Icons.more_vert),
                            itemBuilder: (context) => [
                                  PopupMenuItem(
                                    value: 1,
                                    child: ListTile(
                                      onTap: () {
                                        Navigator.pop(context);
                                        showMyDialog(title, subtitle, id);
                                      },
                                      leading: Icon(Icons.edit),
                                      title: Text("Edit"),
                                    ),
                                  ),
                                  PopupMenuItem(
                                    value: 1,
                                    child: ListTile(
                                      onTap: () {
                                        databaseRef
                                            .child(id)
                                            .remove()
                                            .then((value) {
                                          Utils().toastMessage("Post Deleted");
                                          Navigator.pop(context);
                                        }).onError((error, stackTrace) {
                                          Utils().toastMessage(error.toString());
                                        });
                                      },
                                      leading: Icon(Icons.delete),
                                      title: Text("Delete"),
                                    ),
                                  )
                                ]),
                        title:
                            Text('${snapshot.child('title').value.toString()}'),
                        subtitle:
                            Text(snapshot.child("subtitle").value.toString()),
                          
                      ),
                    ),
                  );
                } else if (title
                    .toLowerCase()
                    .contains(searchFilter.text.toLowerCase().toLowerCase())) {
                  return SizeTransition(
                    sizeFactor: animation,
                    child: ListTile(
                      iconColor: Colors.red,
                      title:
                          Text('${snapshot.child('title').value.toString()}'),
                      subtitle:
                          Text(snapshot.child("subtitle").value.toString()),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddPostScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> showMyDialog(String title, String subtitle, String id) async {
    _postEditController.text = title;
    _postEditSubController.text = subtitle;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(child: Text("Update Post")),
            content: Container(
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                          controller: _postEditController,
                          decoration: InputDecoration(
                            hintText: 'What is in your mind?',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 20.0),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.green, width: 1.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.green, width: 2.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          maxLines: 6,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter Text";
                            } else {
                              return null;
                            }
                          },
                          controller: _postEditSubController,
                          decoration: InputDecoration(
                            hintText: 'Description',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 20.0),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.green, width: 1.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.green, width: 2.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("Cancle")),
                            SizedBox(
                              width: 10,
                            ),
                            TextButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    databaseRef.child(id).update({
                                      'title': _postEditController.text,
                                      'subtitle': _postEditSubController.text,
                                    }).then((value) {
                                      Utils().toastMessage("Post Update");
                                      Navigator.pop(context);
                                    }).onError((error, stackTrace) {
                                      Utils().toastMessage(error.toString());
                                    });
                                  }
                                },
                                child: Text("Update")),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
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