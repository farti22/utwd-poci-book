import 'package:flutter/material.dart';
import 'package:flutter_poci_book/presentation/lecture_list.dart';
import 'package:flutter_poci_book/presentation/home.dart';

class Lecture extends StatefulWidget {
  const Lecture({Key? key}) : super(key: key);
  @override
  _LectureState createState() => _LectureState();
}

class _LectureState extends State<Lecture>{
  @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Container(
          color: Color(0xFF6200EE),
          padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Color(0xFF6200EE),
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white.withOpacity(.60),
            onTap: (value) {
              if (value == 0);
              if (value == 1){
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LectureList()));
              };
              if (value == 2);
            },
            items:[
                    BottomNavigationBarItem(
              title: Text(''),
              icon: Icon(Icons.arrow_back_ios_rounded),
            ),
            BottomNavigationBarItem(
              title: Text(''),
              icon: Icon(Icons.menu),
            ),
            BottomNavigationBarItem(
              title: Text(''),
              icon: Icon(Icons.arrow_forward_ios_rounded),
            )
            ]
          )
      ));
  }
}

