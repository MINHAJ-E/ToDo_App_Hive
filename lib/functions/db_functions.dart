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
  final studentdb = await Hive.openBox<TodoModel>('student_db');
  todoListNotifier.value.clear();
  todoListNotifier.value.addAll(studentdb.values);
  todoListNotifier.notifyListeners();
}

void deleteTask(int id) async {
  final studentdb = await Hive.openBox<TodoModel>('student_db');
  await studentdb.deleteAt(id);
  getAllTasks();
}

void checkboxx(int id, bool newValue) async {
  final studentdb = await Hive.openBox<TodoModel>('student_db');
  final todoModel = studentdb.getAt(id);
  if (todoModel != null) {
    todoModel.isDone = newValue;
    await studentdb.put(id, todoModel); 
    getAllTasks();
  }
}

