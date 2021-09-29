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
      child: InkWell(
        onTap: () {
          print("Container tap");
        },
        child: Container(
          margin: const EdgeInsets.all(30.0),
          color: Colors.blueAccent,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  widget.icon,
                  size: 32.0,
                  color: Colors.white,
                ),
                Text(
                  widget.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                  ),
                ),
              ],
            ),
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
        appBar: AppBar(title: const Text("PoCI App | Главная")),
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
