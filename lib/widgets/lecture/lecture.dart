import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_poci_book/widgets/lecture/lecture_list.dart';

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
          leading: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LectureList()));
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

class LectureSearch extends StatefulWidget {
  const LectureSearch({Key? key}) : super(key: key);
  @override
  _LectureSearchState createState() => _LectureSearchState();
}

class _LectureSearchState extends State<LectureSearch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0.0,
          centerTitle: true,
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          // The search area here
          title: Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: Center(
              child: TextField(
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        /* Clear the search field */
                      },
                    ),
                    hintText: 'Поиск...',
                    border: InputBorder.none),
              ),
            ),
          )),
    );
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
                  children: [
                    Text("Лекция 1", style: TextStyle(fontSize: 20)),
                    Divider(),
                    Text("Многа текста", style: TextStyle(fontSize: 14))
                  ],
                ))));
  }
}
