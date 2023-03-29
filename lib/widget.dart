import 'package:flutter/material.dart';

class taskcardwidget extends StatelessWidget {
  final String title;
  final String? desc;
  taskcardwidget({required this.title, this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 20.0,
      ),
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 32.0,
      ),
      decoration: BoxDecoration(
          color: Colors.white30, borderRadius: BorderRadius.circular(20.0)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          title ?? "Unnamed",
          style: TextStyle(
              color: Colors.white,
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic),
        ),
        Padding(
            padding: EdgeInsets.only(
          top: 10.0,
        )),
        Text(
          desc ?? " ",
          style: TextStyle(
            color: Color.fromARGB(255, 82, 203, 255),
            fontSize: 16.0,
            height: 1.5,
          ),
        ),
      ]
          // decoration: InputDecoration(fillColor: Colors.orange, filled: true),
          ),
    );
  }
}

class Todowidget extends StatelessWidget {
  //const Todowidget({Key? key}) : super(key: key);
  // final
  String? text;
  bool isDone;

  Todowidget({this.text, required this.isDone});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 8.0,
      ),
      child: Row(children: [
        Container(
          width: 20.0,
          height: 20.0,
          margin: EdgeInsets.only(
            right: 12.0,
          ),
          decoration: BoxDecoration(
              color: isDone ? Color(0xFF607D8B) : Colors.transparent,
              borderRadius: BorderRadius.circular(6.0),
              border: isDone
                  ? null
                  : Border.all(
                      color: Color(0xFF868290),
                      width: 1.5,
                    )),
          child: Image(
            image: AssetImage('assets/Images/check_icon.png'),
          ),
        ),
        Flexible(
          child: Text(
            text ?? "Unnamed",
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.0,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ]),
    );
  }
}
