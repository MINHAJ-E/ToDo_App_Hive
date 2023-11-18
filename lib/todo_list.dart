// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_hive/functions/db_functions.dart';
import 'package:todo_hive/model/model.dart';
import 'package:todo_hive/screen_checked.dart';
import 'package:todo_hive/screen_unchecked.dart';
import 'package:todo_hive/screens/provider.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({Key? key}) : super(key: key);

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  final TextEditingController _taskController = TextEditingController();
 

  @override   
  void initState() {
    super.initState();
    
Future.delayed(Duration.zero, () {
    Provider.of<TodoProvider>(context, listen: false).searchedlist = todoListNotifier.value;
  });
 
  }

// String search="";

  @override
  Widget build(BuildContext context) {
    
    getAllTasks();
   var todoprovider =Provider.of<TodoProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Center(
          child: Text(
            'TO DO',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
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
  todoprovider.search = value;
  todoprovider.searchResult(value);
}, 
            ),
          ),
          Expanded(
            child: ValueListenableBuilder<List<TodoModel>>(
              valueListenable: todoListNotifier,
              builder: (BuildContext context, List<TodoModel> todoList,
                   _) {
                return ListView.builder(
                  itemCount: todoprovider.searchedlist.length,
                  itemBuilder: (context, index) {
                    final data =todoprovider. searchedlist[index];
                    return SizedBox(
                      width: 200,
                      height: 100,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Card(
                          color: Colors.amber,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          elevation: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              title: Text(
                                data.task,
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              trailing: IconButton(
                                onPressed: () 
                                {
                                todoprovider.deletetodo(index);
                                },
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                              ),

                              //xheck
                              leading: Checkbox(
                                value: data.isDone,
                                onChanged: (newvalue) {
                                 
                                    data.isDone = newvalue!;
                                   
                                     todoprovider.checkkbox(index, data);
                                 
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
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => alert(context),
              );
            },
            backgroundColor: Colors.amberAccent,
            child: Icon(Icons.add),
          ),
          SizedBox(width: 16),
          FloatingActionButton(
            onPressed: () {
              final checkedTaskss =todoprovider. searchedlist.where((taskss) => taskss.isDone).toList();
              Navigator.push( context, MaterialPageRoute(
                  builder: (context) =>
                      CheckedTasksPage(checkedTasks: checkedTaskss),
                ),
              );
            },
            backgroundColor: Colors.green,
            child: Icon(Icons.check),
          ),
          SizedBox(width: 16),
          FloatingActionButton(
            onPressed: () {
              final uncheckedTaskss =
                 todoprovider. searchedlist.where((task) => !task.isDone).toList();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      UncheckedTasksPage(uncheckedTasks: uncheckedTaskss),
                ),
              );
            },
            backgroundColor: Colors.red,
            child: Icon(Icons.close),
          ),
        ],
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
            _taskController.text='';
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
    final task = _taskController.text.trim();
    if (task.isEmpty) {
      return;
    }
    final toDo = TodoModel(task: task, isDone: false);
    await addtask(toDo);
  }
}
