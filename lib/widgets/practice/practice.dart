import 'package:flutter/material.dart';

class PracticeTask extends StatefulWidget {
  const PracticeTask({Key? key}) : super(key: key);

  @override
  _PracticeTaskState createState() => _PracticeTaskState();
}

class _PracticeTaskState extends State<PracticeTask> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: const Center(
        child: Text(
          "Task #",
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: Colors.green.shade400,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 1,
            offset: const Offset(0, 2),
          ),
        ],
      ),
    );
  }
}

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
          elevation: 0.0,
          centerTitle: true,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        body: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(24),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          crossAxisCount: 2,
          children: const <Widget>[
            PracticeTask(),
            PracticeTask(),
            PracticeTask(),
            PracticeTask(),
            PracticeTask(),
            PracticeTask(),
            PracticeTask(),
            PracticeTask(),
            PracticeTask(),
            PracticeTask(),
            PracticeTask(),
          ],
        ),
      ),
    );
  }
}
