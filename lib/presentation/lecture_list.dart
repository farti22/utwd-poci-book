import 'package:flutter/material.dart';

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
        AppBar(
          title: const Text("Cодержание"),
          elevation: 0.0,
          centerTitle: true,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        Container(
          padding: EdgeInsets.fromLTRB(0, 75, 0, 0),
          child: ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: 30,
            separatorBuilder: (BuildContext context, int index) => Divider(),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text("Лекция №$index", style: TextStyle(fontSize: 22))
                );
            }
        ))
      ]));
  }
}