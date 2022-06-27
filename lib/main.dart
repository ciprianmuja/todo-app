// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:authenticationfirebase/authentication/routeAuth.dart';
import 'package:firebase_core/firebase_core.dart';

//import 'package:authenticationfirebase/utils/utils.dart';

Future<void> main() async {
  //Basic firebase main func layout
  //Glue that binds the framework to the flutter engine
  WidgetsFlutterBinding.ensureInitialized();
  //Initializing FireBase app instance
  await Firebase.initializeApp();

  runApp(MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //navigatorKey: Utils.messengerKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
                primarySwatch: Colors.blueGrey, brightness: Brightness.dark)
            .copyWith(secondary: Colors.greenAccent),
      ),
      //
      home: RouteAuth(),
    );
  }
}
