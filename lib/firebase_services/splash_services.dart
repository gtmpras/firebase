
import 'dart:async';
import 'package:fire_base/ui/auth/login_screen.dart';
import 'package:fire_base/ui/splash_screen.dart';
import 'package:flutter/material.dart';
class SplashServies{

  void isLogin(BuildContext context){

   Timer(Duration(seconds: 3), 
   ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen())));
  }
}