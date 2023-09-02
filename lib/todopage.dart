// // ignore_for_file: prefer_const_constructors
// import 'package:flutter/material.dart';
// import 'package:todo_hive/functions/db_functions.dart';
// import 'package:todo_hive/model/model.dart';
// import 'package:todo_hive/todo_list.dart';

// class ToDoPage extends StatefulWidget {
//   const ToDoPage({super.key});

//   @override
//   State<ToDoPage> createState() => _ToDoPageState();
// }

// class _ToDoPageState extends State<ToDoPage> {
//    TextEditingController _taskController = TextEditingController();
//   @override
//    Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.amber,
//         title: Text('TO DO'),
        
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           showDialog(
//             context: context,
//             builder: (context) => alert(context),
//           );
//         },
//         backgroundColor: Colors.amber,
//         child: Icon(Icons.add),
//       ),
//       // body: ToDoList(
//       //   name: "exercisw",
//       //   taskComplete: true,
//       //   onChanged: (p0){}
//       //   ),
//     );
//   }

//   AlertDialog alert(BuildContext context) {
//     return AlertDialog(
//       title: Text('ADD TODO TASKS'),
//       content: TextField(
//         controller: _taskController,
//           decoration: InputDecoration(
//             border: OutlineInputBorder(),
//           ),
//       ),
//       actions: [
//         TextButton(
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//           child: Text('SAVE'),
//         ),
//         TextButton(
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//           child: Text('CANCEL'),
//         ),
//       ],
//       elevation: 24.0,
//       backgroundColor: Colors.amber,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10),
//       ),
//     );
//   }
// Future <void> pressButton()async{
//   final _task=_taskController.text.trim();
//   if(_task.isEmpty){
//       return;
//   }
//   final _toDo = TodoModel(task: _task, isDone: false);
//   addtask(_toDo);
// }

// }
