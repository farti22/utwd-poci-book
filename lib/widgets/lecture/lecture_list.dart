import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_poci_book/domain/lesson.dart';

class LectureList extends StatefulWidget {
  const LectureList({Key? key}) : super(key: key);
  @override
  _LectureListState createState() => _LectureListState();
}

class _LectureListState extends State<LectureList>{

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
    body: StreamBuilder(
      stream: FirebaseFirestore.instance.collection('test').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
        if (!snapshot.hasData) return Text("Загрузка...");
          return ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: snapshot.data!.docs.length,
              separatorBuilder: (BuildContext context, int index) => Divider(),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal:  30),
                  child: Text(snapshot.data!.docs[index].get('test'), style: TextStyle(fontSize: 22))
                );
            }
        );
      }
      )
    );
  }
}


 

            