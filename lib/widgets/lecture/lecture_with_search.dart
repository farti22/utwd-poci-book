import 'package:flutter/material.dart';
import 'package:flutter_poci_book/main.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_poci_book/widgets/utils/appbar.dart';

int getIndex(List arr, dynamic value) {
  int index = 0;
  for (dynamic v in arr) {
    if (v == value) {
      print("index: ${index}");
      return index;
    }
    index++;
  }
  return -1;
}

class LectureWithSearch extends StatefulWidget {
  final int index;
  final String searchText;
  final List<int> indexList;
  const LectureWithSearch(
      {Key? key,
      required this.index,
      required this.searchText,
      required this.indexList})
      : super(key: key);
  @override
  _LectureWithSearchState createState() => _LectureWithSearchState();
}

class _LectureWithSearchState extends State<LectureWithSearch> {
  bool visRight = true;
  bool visLeft = true;

  @override
  void initState() {
    if (widget.index == widget.indexList.first) {
      visLeft = false;
    }
    if (widget.index == widget.indexList.last) {
      visRight = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: UniAppBar(
          context,
          title: Text(
            widget.searchText,
            style: const TextStyle(color: Colors.black),
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
                customRender: {
                  "search": (RenderContext context, Widget child) {
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
                                        builder: (context) => LectureWithSearch(
                                              index: widget.indexList[getIndex(
                                                      widget.indexList,
                                                      widget.index) -
                                                  1],
                                              searchText: widget.searchText,
                                              indexList: widget.indexList,
                                            )));
                              },
                              icon: const Icon(Icons.navigate_before))),
                      Visibility(
                          visible: visRight,
                          child: IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LectureWithSearch(
                                            index: widget.indexList[getIndex(
                                                    widget.indexList,
                                                    widget.index) +
                                                1],
                                            searchText: widget.searchText,
                                            indexList: widget.indexList)));
                              },
                              icon: const Icon(Icons.navigate_next))),
                    ],
                  ))
            ]),
          ),
        ));
  }
}
