import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_base/ui/auth/login_screen.dart';
import 'package:fire_base/ui/firestore/add_firestore_data.dart';
import 'package:fire_base/ui/posts/add_post.dart';
import 'package:fire_base/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FireStoreScreen extends StatefulWidget {
  const FireStoreScreen({super.key});

  @override
  State<FireStoreScreen> createState() => _FireStoreScreenState();
}

class _FireStoreScreenState extends State<FireStoreScreen> {
 
  final auth = FirebaseAuth.instance;
  final searchFilter = TextEditingController();
  final editController = TextEditingController();
  final fireStore = FirebaseFirestore.instance.collection('Prasoon').snapshots();

  CollectionReference ref = FirebaseFirestore.instance.collection('Prasoon');
  //OR final ref1 = FirebseFirestore.instance.collection('Prasoon'); are same choose one wisely
  //specially first one type is considered as best.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, //removing back button
        centerTitle: true,
        title: Text("Firestore"),
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
          SizedBox(
            height: 10,
          ),
         
         StreamBuilder<QuerySnapshot>(stream: fireStore, 
         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
           
           if(snapshot.connectionState == ConnectionState.waiting)
            return CircularProgressIndicator();
          if(snapshot.hasError)
            return Text('Some error');

          return    Expanded(
            //retriving data from firebase
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context,index){

              return ListTile(
                onTap: (){
                  //For Update
                  // ref.doc(snapshot.data!.docs[index]['id'].toString()).update({
                  //   'title': 'Prasoon Gautam Dang'
                  // }).then((value){
                  //   Utils().toastMessage("Updated");
                  // }).onError((error, stackTrace) {
                  //   Utils().toastMessage(error.toString());
                  // });

                  //For delete
                  ref.doc(snapshot.data!.docs[index]['id'].toString()).delete();
                },
                title: Text(snapshot.data!.docs[index]['title'].toString()),
                subtitle: Text(snapshot.data!.docs[index]['id'].toString()),
              );
            })          )
       ;
         }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddFirestoreDataScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> showMyDialogue(String title, String id) async {
    editController.text = title;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Update'),
            content: Container(
              child: TextField(
                controller: editController,
                decoration: InputDecoration(
                  hintText: "Edit here",
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  
                },
                child: Text("Update"),
              ),
            ],
          );
        });
  }
}
