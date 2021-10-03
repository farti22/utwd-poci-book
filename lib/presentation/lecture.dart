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
          leading: IconButton(onPressed: () {
              Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const LectureList()));
          }, 
          icon: Icon(Icons.menu_sharp)),
          title: FlexibleSpaceBar(
            title: Stack(children: [
            Container(
              child: Text("Теория", style: TextStyle(color: Colors.black)),
              margin: EdgeInsets.only(top: 27, left: 16),
            ),
            Container(
              padding: EdgeInsets.only(left: 197, top: 17), 
              child:  IconButton(
              onPressed: (){}, 
              icon: Icon(Icons.search_sharp))
            )
           
            ]
          ))),
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
        height: 200,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            border: Border.all(color: Colors.black38)),
        child: InkWell(
            child: Container(
                alignment: Alignment.center,
                child: Column(
                  children: [Text("Лекция 1", style: TextStyle(fontSize: 20)), Divider(), Text("Многа текста", style: TextStyle(fontSize: 14))],
                ))));
  }
}
