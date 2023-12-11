import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/Data/database.dart';
import 'package:todo/components/dialog_box.dart';

import '../Models/scroll_behavior.dart';
import '../components/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //reference a nox
  final _mybox = Hive.box('MyBox');
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    if (_mybox.get('TODOLIST') == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }

    super.initState();
  }

  //Text Controller
  final _controller = TextEditingController();

  //checkbox changed
  void checkboxChanged(bool? value, int index) {
    setState(() {
      db.todoList[index][1] = !db.todoList[index][1];
    });
    db.updateDataBase();
  }

  //Save new task
  void saveNewTask() {
    setState(() {
      db.todoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  //action dialog
  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return MyDialog(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  //DELETE TASK
  void deleteTask(int index) {
    setState(() {
      db.todoList.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#FFF7FE'),
      appBar: myAppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        backgroundColor: HexColor('#080F0F'),
        child: Icon(
          Icons.add,
          color: HexColor('#E03F12'),
        ),
      ),
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: ListView.builder(
          itemCount: db.todoList.length,
          itemBuilder: (context, index) {
            return ToDoTile(
              taskName: db.todoList[index][0],
              taskCompleted: db.todoList[index][1],
              onChanged: (value) => checkboxChanged(value, index),
              deleteFunction: (context) => deleteTask(index),
            );
          },
        ),
      ),
    );
  }
}

AppBar myAppBar() {
  return AppBar(
    toolbarHeight: 100,
    elevation: 0,
    backgroundColor: HexColor('#FFF7FE'),
    title: Center(
      child: Text(
        'TO DO LIST',
        style: GoogleFonts.tenorSans(
          color: HexColor('#181820'),
          fontWeight: FontWeight.w800,
        ),
      ),
    ),
  );
}
