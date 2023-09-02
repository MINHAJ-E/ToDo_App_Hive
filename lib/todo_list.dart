// ignore_for_file: prefer_const_constructors
import 'dart:js_util';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todo_hive/functions/db_functions.dart';
import 'package:todo_hive/model/model.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({ Key? key,});

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  TextEditingController _taskController = TextEditingController();

   String _search = '';
  List<TodoModel> searchedlist = [];
  loadstudent() async {
    searchedlist = await getAllTasks();
    searchResult(); 
  }
  @override
  void initState() {
    loadstudent();
    super.initState();
  }
  void searchResult() {
    setState(() {
      searchedlist = todoListNotifier.value
          .where((todoModel) =>
              todoModel.task.toLowerCase().contains(_search.toLowerCase()))
          .toList();
    });
  }
  @override
  Widget build(BuildContext context) {
    getAllTasks();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Align(
        child: Center(
        child: Text('TO DO',
        style: TextStyle(fontWeight: FontWeight.bold),))),       
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(0)),       
        ),         
      ),     
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: 'Search',
                contentPadding: EdgeInsets.all(15),
                prefixIcon: Icon(Icons.search, color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                filled: true,
                fillColor: Colors.amber,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      color: Color.fromARGB(255, 79, 24, 4), width: 2),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _search = value;
                });
                searchResult();
              },
            ),
            ),
               Expanded(
                child: ValueListenableBuilder<List<TodoModel>>(
                  valueListenable: todoListNotifier,
                  builder:
                      (BuildContext context, List<TodoModel> todoList, Widget? child) {
                    return ListView.builder(
                      itemCount: searchedlist.length,
                      itemBuilder: (context, index) {
                        final data = searchedlist[index];
                        return Container(
                          width: 200,
                          height: 100,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Card(
                              color: Colors.amber,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              elevation: 0,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  title: Text(data.task, style: TextStyle(fontStyle: FontStyle.italic,fontWeight: FontWeight.bold),),
                                  trailing: IconButton(
                                    onPressed: () {
                                      deleteTask(index);
                                    },
                                    icon: const Icon(Icons.delete, color: Colors.red),
                                  ),
                                  leading: Checkbox(
                                    value: data.isDone,
                                    onChanged: (value) {
                                      setState(() {
                                        data.isDone = value!;
                                        
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),         
        ],),  
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => alert(context),
          );
        },
        backgroundColor: Colors.amber,
        child: Icon(Icons.add),
      ),
    );
  }
  AlertDialog alert(BuildContext context) {
    return AlertDialog(
      title: Text('ADD TODO TASKS'),
      content: TextField(
        controller: _taskController,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            saved();
            Navigator.of(context).pop();
          },
          child: Text('SAVE'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('CANCEL'),
        ),
      ],
      elevation: 24.0,
      backgroundColor: Colors.amber,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  Future<void> saved() async {
    final _task = _taskController.text.trim();   
    if (_task.isEmpty) {
      return;
    }
    final _toDo = TodoModel(task: _task,isDone:false);
    addtask(_toDo);
  }
}