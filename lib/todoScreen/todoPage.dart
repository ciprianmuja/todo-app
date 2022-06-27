// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

//Creating todo class to determine what variables go into list
class Todo {
  Todo({required this.name, required this.checked});
  final String name;
  bool checked;
}

//
class TodoScreen extends StatefulWidget {
  TodoScreen({Key? key}) : super(key: key);

  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  //
  //Creating controller for the text field
  final TextEditingController _textFieldController = TextEditingController();
  //
  //List to hold the name and checked data
  final List<Todo> _todos = <Todo>[];
  //
  //Adding name and checked to list
  void _addTodoItem(String name) {
    setState(() {
      _todos.add(Todo(name: name, checked: false));
    });
    _textFieldController.clear();
  }

  //

  //
  //Creating a pop up with a text form field to enter tasks
  Future<void> _displayDialog() async {
    //showing dialog
    return showDialog(
      context: context,
      //Barrier not being able to close with outside touch
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Add a new todo item",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          //Creating TextField to get user input (could set it up with text field validation)
          content: TextField(
            controller: _textFieldController,
            decoration: const InputDecoration(
                hintText: "Type your new todo",
                hintStyle: TextStyle(fontWeight: FontWeight.bold)),
          ),
          //Popping the dialog and adding data to list
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _addTodoItem(_textFieldController.text);
              },
              child: const Text(
                "Add",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            )
          ],
        );
      },
    );
  }

  //
  //Handle the state of checking
  void _handleTodoChange(Todo todo) {
    setState(() {
      todo.checked = !todo.checked;
    });
  }
  //

  @override
  Widget build(BuildContext context) {
    //
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

      //Create body for showing tasks
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        children: _todos.map((Todo todo) {
          return TodoItem(
            todo: todo,
            onTodoChanged: _handleTodoChange,
          );
        }).toList(),
      ),
      //Button for adding task
      floatingActionButton: FloatingActionButton(
        onPressed: () => _displayDialog(),
        tooltip: "Add Item",
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}

class TodoItem extends StatelessWidget {
  //Constructor
  TodoItem({required this.todo, required this.onTodoChanged})
      : super(key: ObjectKey(todo));
  //Initialize
  final Todo todo;
  //

  //Is tied with the TextStyle from under
  //Text stle of the tasks -if pressed line through it if not leave it like that-
  final onTodoChanged;
  TextStyle? _getTextStyle(bool checked) {
    //If checked is false return null
    if (!checked) return null;

    return TextStyle(
      color: Colors.greenAccent,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  //Setting up tile content
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(top: 20, bottom: 20, right: 30, left: 30),
      //Change checked state when tapped
      onTap: () {
        onTodoChanged(todo);
      },
      //Leading icon for looks
      leading: Icon(Icons.circle),
      //Setting up the title so that it shows the name of the to do and the style to update the state
      title: Text(
        todo.name,
        style: _getTextStyle(todo.checked),
      ),
      //Setting gap between leading, trailing and title
      horizontalTitleGap: 5,
      //Trailing icon for looks as well lol xD
      trailing: Icon(Icons.hourglass_empty),
    );
  }
}
