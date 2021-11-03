import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_poci_book/main.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_poci_book/widgets/lecture/list.dart';
import 'package:html/parser.dart' as htmlparser;

class Lecture extends StatefulWidget {
  final int index;
  const Lecture({Key? key, required this.index}) : super(key: key);
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
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_outlined),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LectureList()));
            },
          ),
          title: Text(
            listData[widget.index].name,
            style: const TextStyle(color: Colors.black),
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
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Visibility(
                          visible: visLeft,
                          child: IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Lecture(index: widget.index - 1)));
                              },
                              icon: const Icon(Icons.navigate_before))),
                      Visibility(
                          visible: visRight,
                          child: IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Lecture(index: widget.index + 1)));
                              },
                              icon: const Icon(Icons.navigate_next))),
                    ],
                  ))
            ]),
          ),
        ));
  }
}
