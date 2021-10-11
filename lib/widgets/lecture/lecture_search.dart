import 'package:flutter/material.dart';

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
