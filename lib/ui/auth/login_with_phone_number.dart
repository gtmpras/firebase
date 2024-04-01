import 'package:fire_base/ui/auth/verify_code.dart';
import 'package:fire_base/utils/utils.dart';
import 'package:fire_base/widgets/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginWithPhoneNumber extends StatefulWidget {
  const LoginWithPhoneNumber({super.key});

  @override
  State<LoginWithPhoneNumber> createState() => _LoginWithPhoneNumberState();
}

class _LoginWithPhoneNumberState extends State<LoginWithPhoneNumber> {
  
  bool loading = false;
  final phoneNumberController = TextEditingController();
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login"),),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal:20.0),
        child: Column(
          children: [
            SizedBox(height: 50,),
            TextFormField(
        controller: phoneNumberController,
        decoration: InputDecoration(
          hintText: "+977 9812445713"
        ),
            ),
            SizedBox(height: 80,),
            RoundButton(title: "Login", ontap: (){

                auth.verifyPhoneNumber(
                  phoneNumber: phoneNumberController.text.toString(),
                  verificationCompleted: (_){}, 
                verificationFailed: (e){
                  Utils().toastMessage(e.toString());
                }, 
                codeSent: (String verificationId, int? token){
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context)=>VerifyCodeScreen(
                      verificationId: verificationId,)));
                },
                 codeAutoRetrievalTimeout: (e){
                  Utils().toastMessage(e.toString());
                 });
            })
          ],
        ),
      ),
    );
  }
}