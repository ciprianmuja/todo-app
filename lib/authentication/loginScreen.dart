// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'routeAuth.dart';
import 'forgotPasswordPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';
//This is the ui for the login page

class LoginScreen extends StatefulWidget {
  //
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //Firebase login
  final formKey = GlobalKey<FormState>();
  //Creating controller variables to listen to the email and password fields
  //bool isLogin = true;
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

  //Firebase login end
  @override
  Widget build(BuildContext context) {
    //Creating back button in scaffold
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          //Creating Back button to route to main page
          Positioned(
            bottom: 550,
            left: 30,
            child: FloatingActionButton.extended(
              onPressed: (() {
                Navigator.of(context).pop(RouteAuth());
              }),
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                //color: Colors.greenAccent,
              ),
              label: const Text(
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
          padding: EdgeInsets.only(top: 250, left: 80, right: 80),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Creating sign in text
                Text(
                  "SignIn",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                //Creating email text form field for validation
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
                  //Validating email field using email_validator lib
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
                  //Validating password field using normal length func
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (password) =>
                      password != null && password.length < 6
                          ? "Enter a minimum of 6 characters"
                          : null,
                ),
                SizedBox(height: 10),
                //Creating the SignIn button
                ElevatedButton.icon(
                  icon: Icon(
                    Icons.login,
                    size: 20,
                  ),
                  label: Text(
                    "SignIn",
                    style: TextStyle(fontSize: 14),
                  ),
                  //when pressed call the signIn method
                  onPressed: signIn,
                ),
                //SizedBox(height: 16),
                //
                //Creating a forgot password text to navigate to ForgotPasswordPage
                GestureDetector(
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 15,
                    ),
                  ),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ForgotPasswordPage(),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  //Firebase signIn method
  //Creating signIn method that takes in the email and password
  Future signIn() async {
    //With the help of the form key we will validate the input fields
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;
    //Putting email and password getters in a try statement to catch errors
    try {
      //Getting and sending email and password values on pressed
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      //Catching errors so we can output snacKBar email error to user
    } on FirebaseAuthException catch (e) {
      //Creating subScaffold messenger as snackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
          backgroundColor: Colors.red.shade400,
        ),
      );
    }
  }
  //Firebase signIn method end
}
