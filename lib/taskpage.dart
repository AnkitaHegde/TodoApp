//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:todo_list_app/database_helper.dart';
import 'package:todo_list_app/task.dart';
import 'package:todo_list_app/todo.dart';
import 'package:todo_list_app/widget.dart';

class Taskpage extends StatefulWidget {
  final Task? task;
  const Taskpage({this.task});

  @override
  _TaskpageState createState() => _TaskpageState();
}

class _TaskpageState extends State<Taskpage> {
  DatabaseHelper _dbHelper = DatabaseHelper();

  int _taskId = 0;
  String? _taskTitle = "";
  String? _taskDescription = "";

  late final FocusNode _titleFocus;
  late FocusNode _descriptionFocus;
  late FocusNode _todoFocus;

  bool _contentVisible = false;

  @override
  void initState() {
    if (widget.task != null) {
      _contentVisible = true;
      _taskTitle = widget.task!.title;
      _taskDescription = widget.task!.description;
      _taskId = widget.task!.id!;
    }

    _titleFocus = FocusNode();
    _descriptionFocus = FocusNode();
    _todoFocus = FocusNode();
    super.initState();
  }

  void dispose() {
    _titleFocus.dispose();
    _todoFocus.dispose();
    _descriptionFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.grey[300],
          child: Stack(children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Image(
                        image: AssetImage("assets/Images/back_arrow.png"),
                      ),
                    ),
                  ),
                  Expanded(
                      child: TextField(
                    focusNode: _titleFocus,
                    onSubmitted: (value) async {
                      // print("Field value: $value");

                      if (value != "") {
                        //if there is a task then we use database i.e., if value is not equal to null

                        //check if task is null
                        if (widget.task == null) {
                          Task _newTask = Task(
                            title: value,
                            // description: '',
                            // id: 0 //see for this if app didnot work bcs id is given 0 so
                          );

                          _taskId = await _dbHelper.insertTask(_newTask);
                          setState(() {
                            _contentVisible = true;
                            _taskTitle = value;
                          });
                        } else {
                          await _dbHelper.updateTaskTitle(_taskId, value);
                          print("TAsk updated");
                        }
                        //here once title is added then on enter the pointer will move to descriptiomn line
                        _descriptionFocus.requestFocus();
                      }
                    },
                    controller: TextEditingController()..text = _taskTitle!,
                    decoration: InputDecoration(
                        hintText: "Enter Task Title", border: InputBorder.none),
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ))
                ],
              ),
              Visibility(
                visible: _contentVisible,
                child: Padding(
                  padding: const EdgeInsets.only(
                    bottom: 12.0,
                  ),
                  child: TextField(
                    focusNode: _descriptionFocus,
                    onSubmitted: (value) async {
                      if (value != " ") {
                        if (_taskId != 0) {
                          await _dbHelper.updateTaskDiscription(_taskId, value);
                          _taskDescription = value;
                        }
                      }
                      _todoFocus.requestFocus();
                    },
                    controller: TextEditingController()
                      ..text = _taskDescription!,
                    decoration: InputDecoration(
                        hintText: "Enter Description for the task......",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 24.0,
                        )),
                  ),
                ),
              ),
              Visibility(
                visible: _contentVisible,
                child: Expanded(
                  child: SizedBox(
                    height: 200.0,
                    child: FutureBuilder(
                      initialData: [],
                      future: _dbHelper.getTodo(_taskId),
                      builder: (context, snapshot) {
                        return ListView.builder(
                          itemCount: (snapshot.data as List).length,
                          itemBuilder: ((context, index) {
                            return GestureDetector(
                              onTap: (() async {
                                if ((snapshot.data as List)[index].isDone ==
                                    0) {
                                  await _dbHelper.updateTodoDone(
                                      (snapshot.data as List)[index].id, 1);
                                } else {
                                  await _dbHelper.updateTodoDone(
                                      (snapshot.data as List)[index].id, 0);
                                }
                                setState(() {});
                              }),
                              child: Todowidget(
                                  text: (snapshot.data as List)[index].title,
                                  isDone:
                                      (snapshot.data as List)[index].isDone == 0
                                          ? false
                                          : true),
                            );
                          }),
                        );
                      },
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: _contentVisible,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 24.0),
                      child: Container(
                        width: 20.0,
                        height: 20.0,
                        margin: EdgeInsets.only(
                          right: 12.0,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(6.0),
                            border: Border.all(
                              color: Color(0xFF868290),
                              width: 1.5,
                            )),
                        child: Image(
                          image: AssetImage('assets/Images/check_icon.png'),
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        focusNode: _todoFocus,
                        controller: TextEditingController()..text = "",
                        onSubmitted: (value) async {
                          if (value != "") {
                            //if there is a task then we use database i.e., if value is not equal to null

                            //check if task is null
                            if (_taskId != 0) {
                              DatabaseHelper _dbHelper = DatabaseHelper();

                              Todo _newTodo = Todo(
                                  title: value, isDone: 0, taskId: _taskId);

                              await _dbHelper.insertTodo(_newTodo);
                              setState(() {});
                              _todoFocus.requestFocus();
                            } else {
                              print("No todos");
                            }
                          }
                        },
                        decoration: InputDecoration(
                          hintText: "Enter your todo..",
                          border: InputBorder.none,
                        ),
                      ),
                      // flex: 10,
                    )
                  ],
                ),
              )
            ]),
            Visibility(
              visible: _contentVisible,
              child: Positioned(
                  bottom: 24.0,
                  right: 24.0,
                  child: GestureDetector(
                    onTap: () async {
                      if (_taskId != 0) {
                        await _dbHelper.deleteTask(_taskId);
                        Navigator.pop(context);
                      }
                    },
                    child: Container(
                        width: 60.0,
                        height: 60.0,
                        // decoration: BoxDecoration(color: Colors.white30),
                        child: Image(
                          image: AssetImage("assets/Images/delete_icon.png"),
                        )),
                  )),
            ),
          ]),
        ),
      ),
    );
  }
}
