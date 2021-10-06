import 'package:flutter/material.dart';
import 'package:flutter_poci_book/config.dart';
import 'package:flutter_poci_book/presentation/practice.dart';
import 'package:flutter_poci_book/presentation/lecture.dart';

class HomeButton extends StatefulWidget {
  final String title;
  final IconData icon;
  final Widget route;

  const HomeButton(
      {Key? key, required this.title, required this.icon, required this.route})
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
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => widget.route));
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
                  size: 64.0,
                  color: Colors.green,
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
                  color: Colors.grey.withOpacity(0.4),
                  spreadRadius: 9,
                  blurRadius: 11,
                  offset: const Offset(0, 2),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PoCI Book"),
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              currentTheme.switchTheme();
              print("MOON");
            }, // tipa pominiy temy
            icon: const Icon(Icons.nightlight_round_sharp),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          HomeButton(
            title: "Лекция",
            icon: Icons.accessibility_new_sharp,
            route: const Lecture(),
          ),
          const HomeButton(
            title: "Практика",
            icon: Icons.account_box,
            route: Practice(),
          ),
        ],
      ),
    );
  }
}
