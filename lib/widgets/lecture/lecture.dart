import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_poci_book/main.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_poci_book/widgets/lecture/list.dart';
import 'package:flutter_poci_book/widgets/utils/appbar.dart';

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
      if (index == listData.length - 1) {
        visRight = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _changed(widget.index);
    return Scaffold(
      appBar: UniAppBar(
        context,
        title: const Text(
          "Теория",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_outlined),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const LectureList()));
          },
        ),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            floating: false,
            pinned: false,
            snap: false,
            elevation: 0.0,
            centerTitle: true,
            foregroundColor: Colors.black,
            backgroundColor: Colors.blue,
            expandedHeight: 160.0,
            excludeHeaderSemantics: true,
            leading: Container(),
            flexibleSpace: FlexibleSpaceBar(
              titlePadding:
                  const EdgeInsets.symmetric(vertical: 12, horizontal: 0),
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    flex: 1,
                    child: Visibility(
                      visible: visLeft,
                      child: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  Lecture(index: widget.index - 1),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.navigate_before,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 3,
                    child: Text(
                      listData[widget.index].name,
                      overflow: TextOverflow.fade,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Visibility(
                      visible: visRight,
                      child: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  Lecture(index: widget.index + 1),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.navigate_next,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: InteractiveViewer(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 0.0),
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
                                      Lecture(index: widget.index - 1),
                                ),
                              );
                            },
                            icon: const Icon(Icons.navigate_before),
                          ),
                        ),
                        Visibility(
                          visible: visRight,
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      Lecture(index: widget.index + 1),
                                ),
                              );
                            },
                            icon: const Icon(Icons.navigate_next),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
