import 'package:flutter/material.dart';
import 'package:flutter_poci_book/widgets/lecture/card.dart';
import 'package:flutter_poci_book/main.dart';

class LectureSearch extends StatefulWidget {
  const LectureSearch({Key? key}) : super(key: key);
  @override
  _LectureSearchState createState() => _LectureSearchState();
}

class _LectureSearchState extends State<LectureSearch> {
  var _indexList = [-1];
  var _searchText = "";
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
              onChanged: (str) {
                var regex = RegExp(str, caseSensitive: false);
                int index = 0;

                setState(() {
                  _searchText = str;
                  _indexList = [];
                  if (str == "") _indexList = [-1];
                  for (var value in listData) {
                    if (regex.hasMatch(value.content)) {
                      _indexList.add(index);
                    }
                    index++;
                  }
                });
              },
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      /* Clear the search field */
                    },
                  ),
                  hintText: 'Поиск...',
                  border: InputBorder.none),
            ),
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          _indexList.first != -1
              ? SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return LectureCard(
                        index: _indexList[index],
                        searchText: _searchText,
                        indexList: _indexList,
                      );
                    },
                    childCount: _indexList.length,
                  ),
                )
              : const SliverToBoxAdapter(
                  child: Padding(
                  padding: EdgeInsets.only(top: 15.0),
                  child: Text(
                    "Ничего не найдено",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black45,
                      fontSize: 19,
                    ),
                  ),
                )),
        ],
      ),
    );
  }
}
