import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_poci_book/widgets/lecture/lecture_list.dart';
import 'package:flutter_poci_book/widgets/lecture/lecture_search.dart';

class Lecture extends StatefulWidget {
  const Lecture({Key? key}) : super(key: key);
  @override
  _LectureState createState() => _LectureState();
}

class _LectureState extends State<Lecture> {
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
        body: CustomScrollView(slivers: <Widget>[
          SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
          return LectureCard(title: index);
        },
        childCount: 30,
      ))
    ]));
  }
}


class LectureCard extends StatefulWidget {
  final int title;

  const LectureCard({Key? key, required this.title}) : super(key: key);
  @override
  _LectureCardState createState() => _LectureCardState();
}

class _LectureCardState extends State<LectureCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
              Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LectureList()));
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
                Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 10),
                child: Text("Лекция №"+widget.title.toString(), textAlign: TextAlign.center, style: TextStyle(fontSize: 20))),
                Divider(),
                Text("Многа текста", style: TextStyle(fontSize: 14))
              ],
                )));  
  }
}
