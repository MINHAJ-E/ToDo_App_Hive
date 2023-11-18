// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

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

void addCheck(int id,TodoModel data) async {
  final tododb = await Hive.openBox<TodoModel>('student_db');
  await tododb.putAt(id,data);
  getAllTasks();
}