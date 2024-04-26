import 'package:fire_base/utils/utils.dart';
import 'package:fire_base/widgets/round_button.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final postController = TextEditingController();
  bool loading = false;
  final DatabaseRef = FirebaseDatabase.instance
      .ref('Post'); //creating table and providing table_name
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Post"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: postController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "What is in your mind? ",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            RoundButton(
                title: "Add",
                loading: loading,
                ontap: () {
                  setState(() {
                    loading = true;
                  });
                  DatabaseRef.child('1').set({
                    'title': postController.text.toString(),
                    'id': 1,
                  }).then((value) {
                    Utils().toastMessage("Post Added");
                    setState(() {
                      loading = false;
                    });
                  }).onError((error, stackTrace) {
                    Utils().toastMessage(error.toString());
                    setState(() {
                      loading= false;
                    });
                  });
                })
          ],
        ),
      ),
    );
  }
}
