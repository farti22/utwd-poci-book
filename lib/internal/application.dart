import 'package:flutter/material.dart';
import 'package:flutter_poci_book/presentation/home.dart';

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(title: const Text("PoCI App")),
      body: const Center(
          child: Text("PoCI Text",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ))),
    ));
  }
}
