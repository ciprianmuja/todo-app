// ignore_for_file: prefer_const_constructors

import 'package:authenticationfirebase/authentication/signupScreen.dart';
import 'package:authenticationfirebase/homepageScreens/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:authenticationfirebase/authentication/loginScreen.dart';
import 'package:authenticationfirebase/authentication/verifyEmailPage.dart';

class RouteAuth extends StatefulWidget {
  //Optional
  const RouteAuth({Key? key}) : super(key: key);

  @override
  State<RouteAuth> createState() => _RouteAuthState();
}

class _RouteAuthState extends State<RouteAuth> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Setting up the body for the welcome text
      body: Center(
        //Setting up everything in a Stack-like shape
        child: Stack(
          fit: StackFit.expand,
          children: const <Widget>[
            Positioned(
              bottom: 420,
              left: 105,
              child: Icon(
                Icons.calendar_month,
                size: 200,
                color: Colors.greenAccent,
              ),
            ),
            Positioned(
              bottom: 370,
              left: 10,
              child: Text(
                "Welcome to krakenchys ToDoApp!",
                style: TextStyle(
                    fontSize: 23,
                    fontFamily: "Georgia",
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
      //Creating buttons for routing to SignIn and SignUp screen
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      //Placing buttons in a stack
      floatingActionButton: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          //Creating SignIn button with icon and text
          Positioned(
            left: 137,
            bottom: 250,
            //Extending FloatingActionButton so it has room for labels
            child: FloatingActionButton.extended(
              //
              //Routing to SignIn Screen
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    //Firebase
                    builder: (context) => StreamBuilder<User?>(
                      //Displaying changes i.e if the user is already logged in
                      stream: FirebaseAuth.instance.authStateChanges(),
                      builder: (context, snapshot) {
                        //If already logged in return to RoutePage, else route to SignIN
                        //If it's waiting show the loading screen
                        //If it returns and error show an error message
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text("Something went wrong!"));
                        } else if (snapshot.hasData) {
                          return HomePage();
                        } else {
                          return LoginScreen();
                        }
                      },
                    ),
                    //
                  ),
                );
              },
              //
              icon: const Icon(
                Icons.login,
                color: Colors.white,
              ),
              label: const Text(
                "SignIn",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          //Creating the SignUp button with icon and text
          Positioned(
            right: 136,
            bottom: 175,
            //Extending FloatingActionButton so it has room for labels
            child: FloatingActionButton.extended(
              //routing to SignUp Screen
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StreamBuilder<User?>(
                      stream: FirebaseAuth.instance.authStateChanges(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return VerifyEmailPage();
                        } else {
                          return SignupPage();
                        }
                      },
                    ),
                  ),
                );
              },
              icon: const Icon(
                Icons.login,
                color: Colors.white,
              ),
              label: const Text(
                "SignUp",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
