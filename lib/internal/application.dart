import 'package:flutter/material.dart';
import 'package:flutter_poci_book/presentation/home.dart';
//import 'package:flutter_poci_book/presentation/lecture.dart';
//import 'package:flutter_poci_book/presentation/practice.dart';

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}
