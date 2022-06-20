// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:authenticationfirebase/homepageScreens/HomePage.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({Key? key}) : super(key: key);

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  //Creating boolean for email verification checking
  bool isEmailVerified = false;
  //Setting timer variable for timer checking
  Timer? timer;

  @override
  void initState() {
    super.initState();

    //User has to be created before
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    //
    //If email is not verified send a verification email
    if (!isEmailVerified) {
      sendVerificationEmail();

      //Checking for email verification once every 3 seconds
      timer = Timer.periodic(
        Duration(seconds: 3),
        (_) => checkEmailVerified(),
      );
    }
  }

  //
  //Getting rid of the timer after we're done
  @override
  void dispose() {
    timer?.cancel();

    super.dispose();
  }
  //

  Future checkEmailVerified() async {
    //Reloading user before checking for email verification because user can change
    await FirebaseAuth.instance.currentUser!.reload();

    //Setting state for email verification
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    //If the email is verified cancel the timer
    if (isEmailVerified) {
      timer?.cancel();
    }
  }

  //
  //ASYNC method for sending verification email
  Future sendVerificationEmail() async {
    try {
      //gets the current user
      final user = FirebaseAuth.instance.currentUser;
      //sends the verification email
      await user!.sendEmailVerification();
    } catch (e) {
      //Catching errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.red.shade400,
        ),
      );
    }
  }
  //

  @override
  //If email is verified show the home page, else go to verify email page
  Widget build(BuildContext context) => isEmailVerified
      ? HomePage()
      : Scaffold(
          appBar: AppBar(
            title: Text("Verify Email"),
          ),
        );
}
