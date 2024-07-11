
import 'dart:async';
import 'package:fire_base/ui/auth/login_screen.dart';
import 'package:fire_base/ui/firestore/firestore_list_screen.dart';
import 'package:fire_base/ui/posts/post_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class SplashServies{

  void isLogin(BuildContext context){

    final auth = FirebaseAuth.instance;

    final user = auth.currentUser;

    if(user != null){
    Timer(Duration(seconds: 3), 
   ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> FireStoreScreen())));
  
    }else{
      Timer(Duration(seconds: 3), 
   ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen())));
  
    }
  }
}
