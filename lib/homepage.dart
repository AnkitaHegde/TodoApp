import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_list_app/database_helper.dart';
import 'package:todo_list_app/task.dart';
import 'package:todo_list_app/taskpage.dart';
import 'package:todo_list_app/widget.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  DatabaseHelper _dbHelper = DatabaseHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        //width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: 24.0,
        ),
        color: Colors.black,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 50.0),
                  width: 400.0,
                  height: 250.0,
                  decoration: BoxDecoration(
                      //color: Colors.purple,
                      borderRadius: BorderRadius.circular(50.0)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        // height: 20.0,
                        color: Colors.white,
                        image: AssetImage('assets/Images/logo.png'),
                      ),
                      SizedBox(
                        // width: 100.0,
                        height: 10.0,
                      ),
                      Text("TO_DO'S",
                          style: GoogleFonts.nerkoOne(
                            color: Colors.white,
                            fontSize: 50.0,
                            fontWeight: FontWeight.w500,
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Expanded(
                  child: FutureBuilder(
                    initialData: const [],
                    future: _dbHelper.getTasks(),
                    builder: (context, snapshot) {
                      return ScrollConfiguration(
                        behavior: ScrollBehavior(),
                        child: ListView.builder(
                            itemCount: (snapshot.data as List).length,
                            itemBuilder: (context, index) {
                              // print(snapshot.data);
                              return GestureDetector(
                                onTap: (() {
                                  Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Taskpage(
                                                  task: (snapshot.data
                                                      as List)[index])))
                                      .then((value) {
                                    setState(() {});
                                  });
                                }),
                                child: taskcardwidget(
                                  title: (snapshot.data as List)[index].title,
                                  desc: (snapshot.data as List)[index]
                                      .description,
                                ),
                              );
                            }),
                      );
                    },
                  ),
                )
              ],
            ),
            Positioned(
                bottom: 24.0,
                right: 0.0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Taskpage(task: null)),
                    ).then((value) {
                      setState(() {});
                    });
                  },
                  child: Container(
                      width: 60.0,
                      height: 60.0,
                      // decoration: BoxDecoration(color: Colors.white30),
                      child: Image(
                        color: Colors.white,
                        image: AssetImage("assets/Images/add_icon.png"),
                      )),
                )),
          ],
        ),
      ),
    );
  }
}
