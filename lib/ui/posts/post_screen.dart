import 'package:fire_base/ui/auth/login_screen.dart';
import 'package:fire_base/ui/posts/add_post.dart';
import 'package:fire_base/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('Post');//This name should be same as the name in database table

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post Screen"),
        actions: [
          IconButton(
              onPressed: () {
                auth.signOut().then((value) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                }).onError((error, stackTrace) {
                  Utils().toastMessage(error.toString());
                });
              },
              icon: Icon(Icons.logout_outlined)),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            //retriving data from firebase
            child: FirebaseAnimatedList(
              query: ref, 
              defaultChild: Text('Loading'),
              itemBuilder: ((context, snapshot, animation, index) {
                return ListTile(
              title: Text(snapshot.child('title').value.toString(),),
              subtitle: Text(snapshot.child('id').value.toString()),
            );
              })),
          )
          
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>AddPostScreen()));
      },
      child: Icon(Icons.add),),
    );
  }
}
