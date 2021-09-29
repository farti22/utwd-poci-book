import 'package:flutter/material.dart';

const List<String> lec = <String>["Лекция №1", "Лекция №2", "Лекция №3", "Лекция №4", "Лекция №5"];

class LectureList extends StatefulWidget {
  const LectureList({Key? key}) : super(key: key);
  @override
  _LectureListState createState() => _LectureListState();
}

class _LectureListState extends State<LectureList>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Stack(
      children: [
        Container(
          color: Color(0x3F6200EE),
          padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
          child: TextField(decoration: InputDecoration(
            icon: Icon(Icons.adjust_rounded),
            hintText: "Введите информацию",
        ))),
        Container(
          padding: EdgeInsets.fromLTRB(0, 75, 0, 0),
          child: ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: lec.length,
            separatorBuilder: (BuildContext context, int index) => Divider(),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(lec[index], style: TextStyle(fontSize: 22))
                );
            }
        ))
      ]));
  
  }
}