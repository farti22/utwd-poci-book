import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_poci_book/presentation/lecture_list.dart';
import 'package:flutter_poci_book/presentation/home.dart';

class Lecture extends StatefulWidget {
  const Lecture({Key? key}) : super(key: key);
  @override
  _LectureState createState() => _LectureState();
}

class _LectureState extends State<Lecture> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(slivers: <Widget>[
      SliverAppBar(
          elevation: 0.0,
          centerTitle: true,
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu_sharp)),
          title: FlexibleSpaceBar(
            title: Container(
              child: Text("Теория", style: TextStyle(color: Colors.black)),
              margin: EdgeInsets.only(top: 15, left: 16),
            ),
          )),
      SliverList(
          delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return LectureCard();
        },
        childCount: 30,
      ))
    ]));
  }
}

class LectureCard extends StatefulWidget {
  const LectureCard({Key? key}) : super(key: key);
  @override
  _LectureCardState createState() => _LectureCardState();
}

class _LectureCardState extends State<LectureCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 50,
        height: 200,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            border: Border.all(color: Colors.black38)),
        child: InkWell(
            child: Container(
                alignment: Alignment.center,
                child: Column(
                  children: [Text("Лекция 1"), Divider(), Text("Многа текста")],
                ))));
  }
}
