import 'package:flutter/material.dart';

class Practice extends StatefulWidget {
  const Practice({Key? key}) : super(key: key);

  @override
  _PracticeState createState() => _PracticeState();
}

final tabs = ["a", "b", "c"];

class _PracticeState extends State<Practice> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: tabs.length,
        child: Scaffold(
            appBar: AppBar(
              title: const Text("Практика"),
              automaticallyImplyLeading: false,
              bottom: TabBar(
                isScrollable: true,
                tabs: [for (final tab in tabs) Tab(text: tab)],
              ),
            ),
            body: TabBarView(
              children: [for (final tab in tabs) Center(child: Text(tab))],
            )));
  }
}
