// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:todo_hive/model/model.dart';

class CheckedTasksPage extends StatelessWidget {
  final List<TodoModel> checkedTasks;

  CheckedTasksPage({required this.checkedTasks});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checked Tasks'),
        backgroundColor: Colors.green,
      ),
      body:checkedTasks.isNotEmpty? ListView.builder(
        itemCount: checkedTasks.length,
        itemBuilder: (context, index) {
          final data = checkedTasks[index];
          return Container(
            width: 200,
            height: 100,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Card(
                color: Colors.green,
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
      ):Center(child: Text('poyi work cheyy',
      style: TextStyle(fontWeight: FontWeight.bold,fontSize:40 ),),),
    );
  }
}
