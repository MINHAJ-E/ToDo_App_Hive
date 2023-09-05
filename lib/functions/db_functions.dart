import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_hive/model/model.dart';

ValueNotifier<List<TodoModel>> todoListNotifier = ValueNotifier([]);

Future<void> addtask(TodoModel value) async {
  final tododb = await Hive.openBox<TodoModel>('student_db');
  await tododb.add(value);
 todoListNotifier.value.add(value);
  todoListNotifier.notifyListeners();
}

getAllTasks() async {
  final tododb = await Hive.openBox<TodoModel>('student_db');
  todoListNotifier.value.clear();
  todoListNotifier.value.addAll(tododb.values);
  todoListNotifier.notifyListeners();
}

void deleteTask(int id) async {
  final tododb = await Hive.openBox<TodoModel>('student_db');
  await tododb.deleteAt(id);
  getAllTasks();
}
  // void saveTaskToHive(TodoModel todo) async {
  //   final tododb = await Hive.openBox<TodoModel>('student_db');
  //   await tododb.add(todo);
  //   getAllTasks();
  // }

