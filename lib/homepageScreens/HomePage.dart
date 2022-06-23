// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:authenticationfirebase/authentication/routeAuth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:authenticationfirebase/donePage/doneScreen.dart';
import 'package:authenticationfirebase/todoScreen/todoPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    //Creating user variable for getting the current user
    final user = FirebaseAuth.instance.currentUser!;

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
          //SignOut button
          Positioned(
            bottom: 550,
            left: 250,
            child: FloatingActionButton.extended(
              //Signing out
              onPressed: (() => FirebaseAuth.instance.signOut()),
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                //color: Colors.greenAccent,
              ),
              label: const Text(
                "SignOut",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Positioned(
            top: 180,
            left: 50,
            child: Icon(
              Icons.home,
              color: Colors.white,
              size: 300,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 450, left: 142, right: 130),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Creating ToDo button to route to todoPage
            FloatingActionButton.extended(
              //Create route to ToDo page
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TodoScreen(),
                  ),
                );
              },
              label: Text(
                "ToDo",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              icon: Icon(
                Icons.data_object,
                color: Colors.white,
                size: 24,
              ),
            ),
            SizedBox(height: 25),
            //Creating Done button to route to donePage
            FloatingActionButton.extended(
              //Create route to done page
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DoneScreen(),
                  ),
                );
              },
              icon: Icon(
                Icons.done,
                color: Colors.white,
                size: 24,
              ),
              label: Text(
                "Done",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
