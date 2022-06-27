// ignore_for_file: prefer_const_constructors

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'routeAuth.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  //
  //Key and controller for form and email getter
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  //

  //disposing of deleted characters
  @override
  void dispose() {
    emailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //
    //Reset password function for sending an email to the user for password reset
    Future resetPassword() async {
      //Showing loading screen until email sent
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
          child: CircularProgressIndicator(),
        ),
      );
      try {
        //Sending password reset email to email stored in controller
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: emailController.text.trim());
        //
        //Sending confirmation snackBar that email was sent
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Email was sent"),
            backgroundColor: Colors.greenAccent,
          ),
        );
        //
        //Corresponding to loading page, popping it when process done
        Navigator.of(context).popUntil((route) => route.isFirst);
        //
        //Catching errors and outputting them
      } on FirebaseAuthException catch (e) {
        //Creating subScaffold messenger as snackBar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: Colors.red.shade400,
          ),
        );
      }
    }
    //

    //Back button
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
      body: Padding(
        padding: EdgeInsets.only(left: 80, right: 80),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Creating text above field
              Text(
                "Receive an email for password reset.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              //Creating a text form field for email input && validation
              TextFormField(
                controller: emailController,
                cursorColor: Colors.white,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.only(left: 24),
                ),
                //email_validator library
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (email) =>
                    email != null && !EmailValidator.validate(email)
                        ? "Enter a valid email"
                        : null,
              ),
              //SizedBox(height: 10),
              ElevatedButton.icon(
                //
                onPressed: resetPassword,
                //
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(35),
                ),
                icon: Icon(
                  Icons.email_outlined,
                  size: 20,
                ),
                label: Text(
                  "Reset Password",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
