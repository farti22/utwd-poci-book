import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_poci_book/main.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/parser.dart' as htmlparser;

class Lecture extends StatefulWidget {
  final int index;

  Lecture({Key? key, required this.index}) : super(key: key);
  @override
  _LectureState createState() => _LectureState();
}

class _LectureState extends State<Lecture> {
  bool visRight = true;
  bool visLeft = true;

  void _changed(int index) {
    setState(() {
      if (index == 0) {
        visLeft = false;
      }
      if (index == listData.length) {
        visRight = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _changed(widget.index);
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          centerTitle: true,
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          title: Text(
            listData[widget.index].name,
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: InteractiveViewer(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(children: [
              Html(
                data: listData[widget.index].content,
              ),
              Padding(
                  padding: EdgeInsets.only(bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Visibility(
                          visible: visLeft,
                          child: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.arrow_left_sharp))),
                      Visibility(
                          visible: visRight,
                          child: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.arrow_right_sharp))),
                    ],
                  ))
            ]),
          ),
        ));
  }
}
