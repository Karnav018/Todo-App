import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase {
  //data
  List todoList = [];

  //reference a box
  final _mybox = Hive.box('MyBox');

  //first time demo
  void createInitialData() {
    List todoList = [
      ['Make a coffee', false],
      ['Exercise', false],
    ];
  }

//get data
  void loadData() {
    todoList = _mybox.get('TODOLIST');
  }

//update data
  void updateDataBase() {
    _mybox.put('TODOLIST', todoList);
  }
}
