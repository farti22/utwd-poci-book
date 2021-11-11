import 'package:flutter/material.dart';
import 'package:flutter_poci_book/main.dart';
import 'lecture.dart';
import 'lecture_with_search.dart';

class LectureCard extends StatefulWidget {
  final int index;
  final String searchText;
  final List<int> indexList;
  const LectureCard(
      {Key? key,
      required this.index,
      this.searchText = "NULL",
      this.indexList = const []})
      : super(key: key);
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
            builder: (context) => widget.searchText == "NULL"
                ? Lecture(index: widget.index)
                : LectureWithSearch(
                    index: widget.index,
                    searchText: widget.searchText,
                    indexList: widget.indexList),
          ),
        );
      },
      child: Container(
        height: 230,
        alignment: Alignment.bottomCenter,
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(10.0),
          ),
          border: Border.all(color: Colors.blue, width: 2.5),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(50, 15, 50, 10),
              decoration: const BoxDecoration(color: Colors.blue),
              child: Text(
                "Лекция №${listData[widget.index].id}",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Text(
                listData[widget.index].name,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
