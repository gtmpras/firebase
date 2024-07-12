import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_base/utils/utils.dart';
import 'package:fire_base/widgets/round_button.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({super.key});

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  bool loading = false;
  File? _image;
  final picker = ImagePicker();

//firebase storage reference
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  DatabaseReference databaseRef = FirebaseDatabase.instance.ref('Post');

  Future getImageGallery() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image picked');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Image'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: InkWell(
                onTap: () {
                  getImageGallery();
                },
                child: Container(
                  height: 200,
                  width: 200,
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  child: _image != null
                      ? Image.file(_image!.absolute)
                      : Center(child: Icon(Icons.image)),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            RoundButton(
                title: 'Upload',
                loading: loading,
                ontap: () async {
                  setState(() {
                    loading = true;
                  });
                  firebase_storage.Reference ref = firebase_storage
                      .FirebaseStorage.instance
                      .ref('/FolderName' + '1234');
                  firebase_storage.UploadTask uploadTask =
                      ref.putFile(_image!.absolute);

                  await Future.value(uploadTask);
                  var newUrl = ref.getDownloadURL();

                  databaseRef.child('1').set(
                      {'id': '1212', 'title': newUrl.toString()}).then((value) {
                    setState(() {
                      loading = false;
                    });
                    
                  Utils().toastMessage("Uploaded");
                  }).onError((error, stackTrace) {
                    setState(() {
                      loading = false;
                    });
                  });

                })
          ],
        ),
      ),
    );
  }
}
