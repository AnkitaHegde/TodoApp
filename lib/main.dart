import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_list_app/taskpage.dart';
import 'package:todo_list_app/widget.dart';
import 'package:todo_list_app/homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            textTheme: GoogleFonts.jetBrainsMonoTextTheme(
                Theme.of(context).textTheme)),
        home: Homepage());
  }
}

/*class Myhome extends StatelessWidget {
  const Myhome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      children:[

         bottom: 24.0,
          right: 0.0,
      
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Taskpage()),
          );
        },
        child: Container(
          
            width: 60.0,
            height: 60.0,
            decoration: BoxDecoration(color: Colors.white30),
            child: Image(
              image: AssetImage("assets/Images/add_icon.png"),
            )),
      ),
      ],
    );
  }
}*/
