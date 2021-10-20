import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_poci_book/main.dart';
import 'package:flutter_poci_book/domain/lesson.dart';



class LectureNavigator extends StatefulWidget {

  const LectureNavigator({Key? key}) : super(key: key);
  @override
  _LectureNavigatorState createState() => _LectureNavigatorState();
}

class _LectureNavigatorState extends State<LectureNavigator>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
          title: const Text("Cодержание"),
          elevation: 0.0,
          centerTitle: true,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
    body: SingleChildScrollView(
      child: ExpansionPanelList.radio(
          elevation: 3,
          animationDuration: Duration(milliseconds: 700),
          children: listData.map(
                (item) => ExpansionPanelRadio(
                  value: item.id,
                  canTapOnHeader: true,
                  headerBuilder: (_, isExpanded) => Container(
                      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                      child: Text( "Лекция №${item.id}", style: TextStyle(fontSize: 20),
                       )),
                  body: Container(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    child: Text(item.name),
                  ),
                ),
              )
              .toList(),
      ),
    ));
  }
}


 

            
        //     ListView.separated(
        //       padding: const EdgeInsets.all(8),
        //       itemCount: listData.length,
        //       separatorBuilder: (BuildContext context, int index) => Divider(),
        //       itemBuilder: (BuildContext context, int index) {
        //         return Container(
        //           padding: EdgeInsets.symmetric(vertical: 10, horizontal:  30),
        //           child: Text("Лекция №$listData[index].id", style: TextStyle(fontSize: 22))
        //         );
        //     }
        // )