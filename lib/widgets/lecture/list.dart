import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'navigator.dart';
import 'search.dart';
import 'package:flutter_poci_book/main.dart';
import 'card.dart';

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
              icon: const Icon(Icons.menu_sharp)),
          title: const Text("Теория", style: TextStyle(color: Colors.black)),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LectureSearch()));
                },
                icon: const Icon(Icons.search_sharp)),
          ]),
      body: listData.isNotEmpty
          ? CustomScrollView(slivers: <Widget>[
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return LectureCard(index: index);
                  },
                  childCount: 30,
                ),
              ),
            ])
          : const Center(
              child: Text("Включите интернет, чтобы загрузить лекции"),
            ),
    );
  }
}
