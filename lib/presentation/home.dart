import 'package:flutter/material.dart';
//import 'package:flutter_poci_book/presentation/practice.dart';
//import 'package:flutter_poci_book/presentation/lecture.dart';

class HomeButton extends StatefulWidget {
  String title;
  IconData icon;
  HomeButton({Key? key, required this.title, required this.icon})
      : super(key: key);

  @override
  _HomeButtonState createState() => _HomeButtonState();
}

class _HomeButtonState extends State<HomeButton> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Ink(
        child: InkWell(
          splashColor: Colors.greenAccent,
          splashFactory: InkRipple.splashFactory,
          onTap: () {
            print("Container tap");
          },
          child: Container(
            margin: const EdgeInsets.all(30.0),
            alignment: Alignment.center,
            //color: Colors.blueAccent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  widget.icon,
                  size: 32.0,
                  //color: Colors.white,
                ),
                Text(
                  widget.title,
                  style: const TextStyle(
                    //color: Colors.white,
                    fontSize: 32,
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 2),
                  )
                ]),
          ),
        ),
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("PoCI App | Главная"),
          elevation: 0.0,
          centerTitle: true,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        body: Column(
          children: <Widget>[
            HomeButton(title: "Лекция", icon: Icons.accessibility_new_sharp),
            HomeButton(title: "Практика", icon: Icons.account_box),
          ],
        ));
  }

  BottomNavigationBarItem _bottomNavigationItem(String text, Icon icon) {
    return BottomNavigationBarItem(
      label: text,
      icon: icon,
    );
  }
}
