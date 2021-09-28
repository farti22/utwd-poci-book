import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      home: Scaffold(
    appBar: AppBar(title: const Text("PoCI App")),
    body: const Center(
        child: Text("PoCI Text",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ))),
  )));
}
