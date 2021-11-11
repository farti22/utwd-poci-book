import 'package:flutter/material.dart';
import 'package:flutter_poci_book/widgets/practice/widgets/password_gen/view.dart';
import 'package:flutter_poci_book/widgets/practice/widgets/permutation_encrypt/view.dart';
import 'package:flutter_poci_book/widgets/practice/widgets/random_sequence_gen/view.dart';
import 'package:flutter_poci_book/widgets/practice/widgets/replacement_encrypt/view.dart';

class PracticeTask extends StatefulWidget {
  final String title;
  final Widget route;

  const PracticeTask({Key? key, required this.title, required this.route})
      : super(key: key);

  @override
  _PracticeTaskState createState() => _PracticeTaskState();
}

class _PracticeTaskState extends State<PracticeTask> {
  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.blue.shade400,
          width: 2,
        ),
      ),
      child: InkWell(
        splashColor: Colors.blue.shade300,
        splashFactory: InkRipple.splashFactory,
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => widget.route));
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Text(
              widget.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ),
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
            PracticeTask(
              title: "Генератор паролей",
              route: PasswordGeneratorView(),
            ),
            PracticeTask(
              title: "Шифрование методами перестановки",
              route: PermutationEncrypt(),
            ),
            PracticeTask(
              title: "Шифрование методами замены",
              route: ReplacementGenerator(),
            ),
            PracticeTask(
              title: "Реализация генератора псевдослучайной последовательности",
              route: RandomSequenceGen(),
            ),
          ],
        ),
      ),
    );
  }
}
