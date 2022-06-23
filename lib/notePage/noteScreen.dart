// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({Key? key}) : super(key: key);

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  //
  final formKey = GlobalKey<FormState>();
  //Creating a controller for receiving the text from the note field
  final noteController = TextEditingController();
  //
  @override
  Widget build(BuildContext context) {
    //Creating the scaffold of the noteScreen
    return Scaffold(
      //Creating an appBar with a title, color and back button
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Note"),
        backgroundColor: Colors.greenAccent,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 30,
          ),
        ),
      ),
      //Setting up a SingleChildScrollView to place the note and the Add button in
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 50, left: 10, right: 10),
        //Creating it as a form
        child: Form(
          key: formKey,
          //Column but it doesn't really matter as we don't have many elements jur a form field and button
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Creating note field
              TextFormField(
                maxLines: 10,
                controller: noteController,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(top: 10, left: 10),
                  border: OutlineInputBorder(),
                  hintText: "Note...",
                  hintStyle: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
              //SizedBox for space between note field and button
              SizedBox(height: 40),
              //Creating Add button for adding note to ToDo list
              FloatingActionButton.extended(
                //Create logic for adding note
                onPressed: () {},
                label: Text(
                  "Add",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                icon: Icon(
                  Icons.add,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
