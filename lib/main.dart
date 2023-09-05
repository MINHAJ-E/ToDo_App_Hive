// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo_hive/model/model.dart';
import 'package:todo_hive/todo_list.dart';
// import 'package:todo_hive/todopage.dart';

Future<void> main()async{
    WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
 if (!Hive.isAdapterRegistered(TodoModelAdapter().typeId)) {
    Hive.registerAdapter(TodoModelAdapter());
  }
  

  runApp(Myapp());
}
class Myapp extends StatelessWidget {
   Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "TODO HIVE",
      home: ToDoList(),
    );
    
  }
}