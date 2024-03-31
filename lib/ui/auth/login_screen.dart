import 'package:fire_base/consts/strings.dart';
import 'package:fire_base/ui/auth/signup_screen.dart';
import 'package:fire_base/ui/posts/post_screen.dart';
import 'package:fire_base/utils/utils.dart';
import 'package:fire_base/widgets/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance ;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void login(){
    setState(() {
      loading = true;
    });
    _auth.signInWithEmailAndPassword(
      email: emailController.text, 
      password: passwordController.text).then((value){
        Utils().toastMessage(value.user!.email.toString());
        Navigator.push(context, 
        MaterialPageRoute(builder: (context)=>PostScreen()));

        setState(() {
          loading = false;
        });
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      Utils().toastMessage(error.toString());

      setState(() {
        loading = false;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
          title: Text(Login,style: TextStyle(color: Colors.white),),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        decoration: InputDecoration(
                          hintText: email,
                          prefixIcon: Icon(Icons.email),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter email";
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: password,
                          prefixIcon: Icon(Icons.visibility_off),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter password";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ],
                  )),
              SizedBox(
                height: 50,
              ),
              RoundButton(
                title: Login,
                loading: loading,
                ontap: () {
                  if (_formKey.currentState!.validate()) ;
                  login();
                },
              ),
              SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(dontHaveAccount),
                  TextButton(onPressed: (){
                    Navigator.push(context,
                    MaterialPageRoute(builder: (context)=> SignUpScreen()));
                  }, 
                  child:Text(signUp,style: TextStyle(color: Colors.red),))
      
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
