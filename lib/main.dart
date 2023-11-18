// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:todo_hive/model/model.dart';
import 'package:todo_hive/screens/provider.dart';
import 'package:todo_hive/todo_list.dart';
// import 'package:todo_hive/todopage.dart';

Future<void> main()async{
    WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
 if (!Hive.isAdapterRegistered(TodoModelAdapter().typeId)) {
    Hive.registerAdapter(TodoModelAdapter());
  }
  

  runApp(ChangeNotifierProvider(create: (context) => TodoProvider(),child: Myapp(),));
}
class Myapp extends StatelessWidget {
   const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "TODO HIVE",
      home: ToDoList(),
    );
    
  }
}