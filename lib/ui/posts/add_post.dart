import 'package:fire_base/widgets/round_button.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final DatabaseRef = FirebaseDatabase.instance.ref('Post');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Post"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal:20.0),
        child: Column(
          children: [
        SizedBox(height: 30,),
        TextFormField(
          maxLines: 4,
          decoration: InputDecoration(
            hintText: "What is in your mind? ",
            border: OutlineInputBorder(),
            
          ),
        ),
        SizedBox(height: 30,),
      RoundButton(title: "Add", ontap: (){
        DatabaseRef.child(path)
      })
          ],
        ),
      ),
    );
  }
}