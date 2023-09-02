import 'package:hive/hive.dart';
part 'model.g.dart';

@HiveType(typeId: 1)


class TodoModel{

@HiveField(0)
late String task;
@HiveField(1)  
late bool isDone;

  TodoModel({required this.task,required this.isDone});

  
}