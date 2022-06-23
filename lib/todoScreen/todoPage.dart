// ignore_for_file: prefer_const_constructors

import 'package:authenticationfirebase/notePage/noteScreen.dart';
import 'package:flutter/material.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({Key? key}) : super(key: key);

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final List _tasks = [];
  final List _savedTasks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Creating appBar for page with title and back button
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "To Do List",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.greenAccent,
        leading: IconButton(
          //Popping to last page
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 30,
          ),
        ),
      ),
      //
      //Creating button for adding tasks
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          size: 30,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => NoteScreen()));
        },
      ),
      //Create body for adding tasks
      body: Column(), //_buildtasks(),
    );
  }

  //Building the tasks
  //Create it so that it matches what I want to make
  /*Widget _buildtasks() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, item) {
        if (item.isOdd) return Divider();
        final index = item ~/ 2;
        return _buildRow(_tasks[index]);
      },
    );
  }
  */

  //Same thing as above
  /*Widget _buildRow(task) {
    final alreadySaved = _tasks.contains(task);
    return ListTile(
      title: Text(
        "Task",
        style: TextStyle(fontSize: 18),
      ),
      trailing: Icon(
        alreadySaved ? Icons.delete : Icons.delete_outline,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _savedTasks.remove(task);
          } else {
            _savedTasks.add(task);
          }
        });
      },
    );
  }
  */
}
