import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
        body: Stack(
          children: [
            Container(
              color: Colors.green[300],
              padding: EdgeInsets.only(top: 30),
                  child: Stack(
                    children: [
                          Row(
                            children: [IconButton(
                              onPressed: (){
                                Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => const LectureList()));
                              },
                              icon: Icon(Icons.menu_sharp),
                            ),
                            Text("Теория")]),
                      
                          Container(
                            padding: EdgeInsets.only(top: 25),
                            child: TextFormField(
                            initialValue: 'Input text',
                            decoration: InputDecoration(
                            prefix: IconButton(
                              onPressed: (){},
                              icon: Icon(Icons.search_sharp)
                            ),
                            enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                      )),
                  ])),
                Center(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    margin: EdgeInsets.only(top: 125),
                    child: Expanded(
                      child: PageView(
                      scrollDirection: Axis.vertical,
                      children: <Widget>[
                        LectureCard(),
                        LectureCard(),
                        LectureCard()
                      ],
                    )
                  )),
                  )
                ]
                )
      );
  }
}

class LectureCard extends StatefulWidget{
  const LectureCard({Key? key}) : super(key: key);
  @override
  _LectureCardState createState() => _LectureCardState();
}

class _LectureCardState extends State<LectureCard>{
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10), 
      decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
              color: Colors.white24,
              border: Border.all(color: Colors.black)

            ),
      child: InkWell(
        splashColor: Colors.black,
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              Text("Лекция 1"),
              Divider(),
              Text("Многа текста")
            ],
          )
        )

      ));
  }
}