// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(brightness: Brightness.dark),
    home: myApp(),
  ));
}

class myApp extends StatefulWidget {
  const myApp({super.key});

  @override
  State<myApp> createState() => _myAppState();
}

class _myAppState extends State<myApp> {

  //list of Strings
  List<String> displayedTodos = [];
  final List<String> _myTodos = ['Task 1','Task 2','Task 3'];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    displayedTodos = List.from(_myTodos);
  }

  //function for dialog box to edit Todo list
  void editTask(int index){
    String editedTodo = _myTodos[index];

    showDialog(
      context: context,
      builder: (BuildContext context){

        final controller = TextEditingController(text: _myTodos[index]);

        return AlertDialog(
          title: Text('Edit the Task'),
          content: TextField(
            controller: controller,
            onChanged: (value) {
              editedTodo = value;
            },
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Submit'),
              onPressed: () {
                setState(() {
                  _myTodos[index] = editedTodo;
                });
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }
    );
  }

  //Function for Adding new Task;

  void addTask(){
    showDialog(
      context: context,
      builder: (BuildContext context){
        String newTask = '';

        return AlertDialog(
          title: Text('Add new Task'),
          content: TextField(
            decoration: InputDecoration(hintText: 'New Task'),
            onChanged: (value) {
              newTask = value;
            },
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Submit'),
              onPressed: () {
                setState(() {
                  _myTodos.add(newTask);
                  displayedTodos = List.from(_myTodos);
                });
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }
    );
  }

  //funtion to delete task 
  void deleteTask(int index){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text('Delete Task'),
          content: Text('Are you Sure you Want to delete this task'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                setState(() {
                  _myTodos.removeAt(index);
                  displayedTodos = List.from(_myTodos);
                });
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Todo'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 122, 122, 122),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [ 
          Center(
          child: CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage('assets/my_picture.png'),
          ),),
          Divider(
            height: 50,
            color: Colors.grey,
          ),
          Text('name',
          style: TextStyle(
            color: Colors.grey,
          ),
          ),
          SizedBox(height: 5,),
          Text('Oluwakayode',
          style: TextStyle(
            color: Colors.amber,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            ),
            
          ),

          SizedBox(height: 15,),
          
          // Email section
          Text('Email',
          style: TextStyle(
            color: Colors.grey,
          ),
          ),

          SizedBox(height: 5,),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.email, color: Colors.grey,),
              
              SizedBox(height: 5,),
              
              Text('Olukayo1927@gmail.com',
              style: TextStyle(
                color: Colors.amber,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                ),
                
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search Task',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                )
              ),
              onChanged: (value) {
                setState(() {
                  displayedTodos = _myTodos
                    .where((todo) => todo.toLowerCase().contains(value.toLowerCase()))
                    .toList();
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: displayedTodos.length,
              itemBuilder: (context, index) {
                final todo = displayedTodos[index];
            
                return ListTile(
                  leading: Icon(Icons.task),
                  title: Text(todo),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => editTask(index),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => deleteTask(index),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: addTask,backgroundColor: Colors.grey, hoverColor: Colors.amber, child: Icon(Icons.add),),
    );
  }
}