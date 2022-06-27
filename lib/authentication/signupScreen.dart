// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'routeAuth.dart';
import 'package:email_validator/email_validator.dart';

//This is the UI for the SignUp page

class SignupPage extends StatefulWidget {
  //
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  //
  //Creating controller variables to listen to the email and password fields
  final formKey = GlobalKey<FormState>();
  //final messengerKey = GlobalKey<ScaffoldMessengerState>();
  //s
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  //

  //Disposing of the deleted characters
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  //
  @override
  Widget build(BuildContext context) {
    //Sign up method for creating user accounts
    Future signUp() async {
      //With the help of the form key we will validate the input fields
      final isValid = formKey.currentState!.validate();
      if (!isValid) return;

      //try statement for catching errors
      //Getting and sending email and password to firebase for auth creation
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        //Catching errors for shwing in snackBar format
      } on FirebaseAuthException catch (e) {
        //Sub-scaffold messenger for showing to snackBar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString().replaceRange(0, 36, "")),
            backgroundColor: Colors.red.shade400,
          ),
        );
      }
    }

    ;
    return Scaffold(
      //Creating BACK button in scaffold
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Positioned(
            bottom: 550,
            left: 30,
            child: FloatingActionButton.extended(
              onPressed: (() {
                Navigator.of(context).pop(RouteAuth());
              }),
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                //color: Colors.greenAccent,
              ),
              label: Text(
                "Back",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 200, left: 80, right: 80),
        //Creating child form for formKey validation
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 40,
              ),
              //Creating email form field for validation
              TextFormField(
                controller: emailController,
                cursorColor: Colors.white,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  icon: Icon(Icons.abc),
                  contentPadding: EdgeInsets.only(left: 24),
                  border: OutlineInputBorder(),
                  hintText: "Email...",
                  hintStyle: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                //Adding validation for email using email_validator lib
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (email) =>
                    email != null && !EmailValidator.validate(email)
                        ? "Enter a valid email"
                        : null,
              ),
              SizedBox(
                height: 4,
              ),
              TextFormField(
                //Passing in password controller
                controller: passwordController,
                cursorColor: Colors.white,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  icon: Icon(Icons.abc),
                  contentPadding: EdgeInsets.only(left: 24),
                  border: OutlineInputBorder(),
                  hintText: "Passsword...",
                  hintStyle: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                //Creating validation fields using normal statements
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (password) => password != null && password.length < 6
                    ? "Enter a minimum of 6 characters"
                    : null,
              ),
              SizedBox(height: 10),
              ElevatedButton.icon(
                icon: Icon(
                  Icons.login,
                  size: 20,
                ),
                label: Text(
                  "SignUp",
                  style: TextStyle(fontSize: 14),
                ),
                onPressed: signUp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
