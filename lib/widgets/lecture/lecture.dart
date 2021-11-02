import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_poci_book/main.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/parser.dart' as htmlparser;

class Lecture extends StatefulWidget {
  final int index;
  final String searchText;
  Lecture({Key? key, required this.index, required this.searchText})
      : super(key: key);
  @override
  _LectureState createState() => _LectureState();
}

class _LectureState extends State<Lecture> {
  bool visRight = true;
  bool visLeft = true;
  int _count = 0;

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
            widget.searchText == "ERROR"
                ? listData[widget.index].name
                : widget.searchText,
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: InteractiveViewer(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(children: [
              Html(
                data: listData[widget.index].content.replaceAll(
                    RegExp(widget.searchText, caseSensitive: false),
                    "<search></search>"),
                customRender: //widget.searchText == " "
                    //? {}
                    {
                  "search": (RenderContext context, Widget child) {
                    _count++;
                    return TextSpan(
                      text: widget.searchText.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 20,
                        backgroundColor: Colors.yellow,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                },
                tagsList: Html.tags..addAll(["search"]),
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
                              icon: Icon(Icons.navigate_before))),
                      Visibility(
                          visible: visRight,
                          child: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.navigate_next))),
                    ],
                  ))
            ]),
          ),
        ));
  }
}
