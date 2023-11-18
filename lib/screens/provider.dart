import 'package:flutter/material.dart';
import 'package:todo_hive/functions/db_functions.dart';
import 'package:todo_hive/model/model.dart';

class TodoProvider extends ChangeNotifier{
   String search = '';
  List<TodoModel> _searchedlist = [];
    List<TodoModel> get searchedlist => _searchedlist;
  set searchedlist(List<TodoModel> value) {
    _searchedlist = value;
    notifyListeners();
  }
  void deletetodo(index){
      deleteTask(index);
      notifyListeners();
  }

  void checkkbox(index,data){
   
      addCheck(index, data);
      notifyListeners();
  }
    void searchResult(String value) {
    search = value;
    _searchedlist = todoListNotifier.value
        .where((incomingModel) =>
            incomingModel.task.toLowerCase().contains(search.toLowerCase()))
        .toList();
    notifyListeners();
  }
}