// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_hive/functions/db_functions.dart';
import 'package:todo_hive/model/model.dart';
import 'package:todo_hive/screens/screen_checked.dart';
import 'package:todo_hive/screens/screen_unchecked.dart';
// import 'package:todo_hive/screen_unchecked.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({Key? key}) : super(key: key);

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  TextEditingController _taskController = TextEditingController();
  String _search = '';
  List<TodoModel> searchedlist = [];

  @override
  void initState() {
    super.initState();

    getAllTasks();
    searchedlist = todoListNotifier.value;
  }

  void searchResult() {
    setState(() {
      searchedlist = todoListNotifier.value
          .where((incomigModel) =>
              incomigModel.task.toLowerCase().contains(_search.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
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
              builder: (BuildContext context, List<TodoModel> todoList, _) {
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
                                onPressed: () {
                                  deleteTask(index);
                                },
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                              ),

                              //check
                              leading: Checkbox(
                                value: data.isDone,
                                onChanged: (newvalue) {
                                  setState(() async {
                                    data.isDone = newvalue!;
                                    addCheck(index, data);
                                 
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
              final checkedTaskss =
                  searchedlist.where((taskss) => taskss.isDone).toList();
              Navigator.push(
                context,
                MaterialPageRoute(
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
                  searchedlist.where((task) => !task.isDone).toList();
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
            _taskController.text = '';
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
    final toDo = TodoModel(task: _task, isDone: false);
    await addtask(toDo);
  }
}
