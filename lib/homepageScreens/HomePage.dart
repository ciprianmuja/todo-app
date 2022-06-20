import 'package:flutter/material.dart';
import 'package:authenticationfirebase/authentication/routeAuth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
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
        ],
      ),
      body: Padding(
          padding: EdgeInsets.only(left: 125),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [],
          )),
    );
  }
}
