// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:todo_hive/model/model.dart';

class UncheckedTasksPage extends StatelessWidget {
  final List<TodoModel> uncheckedTasks;

  UncheckedTasksPage({required this.uncheckedTasks});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Unchecked Tasks'),
        backgroundColor: Colors.red,
      ),
      body:uncheckedTasks.isNotEmpty? ListView.builder(
        itemCount: uncheckedTasks.length,
        itemBuilder: (context, index) {
          final data = uncheckedTasks[index];
          return Container(
            width: 200,
            height: 100,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Card(
                color: Colors.red,
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
                  ),
                ),
              ),
            ),
          );
        },
      ):Center(child: Text('Ijjonnum cheythittilla',
      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),)
    );
  }
}
