import 'package:fire_base/consts/consts.dart';
import 'package:fire_base/ui/auth/login_screen.dart';
import 'package:fire_base/utils/utils.dart';
import 'package:fire_base/widgets/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailController = TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(forgotPassword),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: email,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            RoundButton(
                title: forgotPassword,
                ontap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                  auth
                      .sendPasswordResetEmail(
                          email: emailController.text.toString())
                      .then((value) {
                    Utils().toastMessage(successMessage);
                  }).onError(
                    (error, stackTrace) {
                      Utils().toastMessage(error.toString());
                    },
                  );
                })
          ],
        ),
      ),
    );
  }
}
