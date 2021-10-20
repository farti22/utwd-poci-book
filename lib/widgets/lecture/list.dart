import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_poci_book/widgets/lecture/navigator.dart';
import 'package:flutter_poci_book/widgets/lecture/search.dart';
import 'package:flutter_poci_book/widgets/lecture/lecture.dart';
import 'package:flutter_poci_book/main.dart';

class LectureList extends StatefulWidget {
  const LectureList({Key? key}) : super(key: key);
  @override
  _LectureListState createState() => _LectureListState();
}

class _LectureListState extends State<LectureList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0.0,
            centerTitle: true,
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
            leading: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LectureNavigator()));
                },
                icon: Icon(Icons.menu_sharp)),
            title: Text("Теория", style: TextStyle(color: Colors.black)),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LectureSearch()));
                  },
                  icon: Icon(Icons.search_sharp)),
            ]),
        body: CustomScrollView(slivers: <Widget>[
          SliverList(
              delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return LectureCard(index: index);
            },
            childCount: 30,
          ))
        ]));
  }
}

class LectureCard extends StatefulWidget {
  final int index;

  const LectureCard({Key? key, required this.index}) : super(key: key);
  @override
  _LectureCardState createState() => _LectureCardState();
}

class _LectureCardState extends State<LectureCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Lecture(index: widget.index)));
        },
        child: Container(
            height: 250,
            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                border: Border.all(color: Colors.black38)),
            child: Column(
              children: [
                Padding(
                    padding: EdgeInsets.fromLTRB(0, 15, 0, 10),
                    child: Text("Лекция №${listData[widget.index].id}",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20))),
                Divider(),
                Text("Нажми на меня!", style: TextStyle(fontSize: 14))
              ],
            )));
  }
}
