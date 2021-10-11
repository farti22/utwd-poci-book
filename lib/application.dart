import 'package:flutter/material.dart';
import 'package:flutter_poci_book/widgets/home.dart';
//import 'package:flutter_poci_book/presentation/lecture.dart';
//import 'package:flutter_poci_book/presentation/practice.dart';

class Application extends StatefulWidget {
  const Application({Key? key}) : super(key: key);

  @override
  _ApplicationState createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}
