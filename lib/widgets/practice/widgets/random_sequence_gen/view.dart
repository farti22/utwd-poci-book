import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:flutter_poci_book/widgets/practice/widgets/random_sequence_gen/internal.dart';
import 'package:flutter_poci_book/widgets/utils/appbar.dart';
import 'package:flutter_poci_book/widgets/utils/outline_textfield.dart';

class RandomSequenceGen extends StatefulWidget {
  const RandomSequenceGen({Key? key}) : super(key: key);
  @override
  _RandomSequenceGenState createState() => _RandomSequenceGenState();
}

class _RandomSequenceGenState extends State<RandomSequenceGen> {
  //Task 1
  final List<String> _genNames = [
    "От 3 до 12, целые",
    "Из множества {–3, 0, 6, 9, 12, 15}",
    "От 3 до 12, вещественные",
    "От –2,3 до 10,7 с шагом 0,1",
    "Из множества {–30; 10; 63; 59; 120; 175}",
    "Из множества {1; 0,1; 0,01; …; 10–15}"
  ];

  //Task 2
  List<String> _gens = [];
  List<int> _amount = [0, 0];
  var game = BullsAndCowsGame();
  bool _win = false;
  var winClearController = TextEditingController();
  int _number = 0;

  Container _ImageCircle(String imgSrc) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(6),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.blue,
          width: 2,
        ),
        shape: BoxShape.circle,
      ),
      child: Image(
        height: 46,
        width: 46,
        image: AssetImage(imgSrc),
      ),
    );
  }

  Container ImageBull() {
    return _ImageCircle("lib/assets/images/bull.png");
  }

  Container ImageCow() {
    return _ImageCircle("lib/assets/images/cow.png");
  }

  @override
  void initState() {
    super.initState();
    game.init();
    //print("init");
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: UniAppBar(
          context,
          title: const Text(
              " Реализация генератора псевдослучайной последовательности"),
          bottom: const TabBar(
            labelColor: Colors.black,
            tabs: <Widget>[
              Tab(
                text: "Задание 1",
              ),
              Tab(
                text: "Задание 2",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 30.0),
              padding: const EdgeInsets.only(
                left: 30.0,
                right: 30.0,
                top: 10.0,
              ),
              child: Column(
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(Icons.lock_open),
                    label: const Text("Сгенерировать"),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(300, 0),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 60.0,
                        vertical: 10.0,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        _gens = randomNumList();
                        print(_gens);
                      });
                    },
                  ),
                  const Divider(),
                  for (var i = 0; i < _gens.length; i++)
                    Container(
                      margin: const EdgeInsets.all(5),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blue,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Column(
                        children: [
                          Text(_genNames[i]),
                          const Divider(),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              _gens[i],
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 30.0),
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 60),
                    child: TextField(
                      textAlign: TextAlign.center,
                      controller: winClearController,
                      onChanged: (number) {
                        setState(() {
                          if (number.length > 0) {
                            _number = int.parse(number);
                          } else {
                            _number = 0;
                          }
                        });
                      },
                      style: TextStyle(
                        fontSize: 22,
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(4),
                      ],
                      decoration: const InputDecoration(
                        labelText: "Число",
                        //hintText: "Введи число",
                        alignLabelWithHint: true,
                      ),
                    ),
                  ),
                  const Divider(),
                  Visibility(
                    visible: !_win,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.remove_red_eye_outlined),
                      label: const Text("Проверить"),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(300, 0),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 60.0,
                          vertical: 10.0,
                        ),
                      ),
                      onPressed: (_number.toString().length >= 4 &&
                              game.isUnique(_number))
                          ? () {
                              setState(() {
                                _amount = game.check(_number);
                                if (_amount[0] == 4) {
                                  _win = true;
                                }
                              });
                              print(_amount);
                            }
                          : null,
                    ),
                  ),
                  Visibility(
                    visible: _win,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.replay_circle_filled),
                      label: const Text("Сыграть ещё"),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        minimumSize: const Size(300, 0),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 60.0,
                          vertical: 10.0,
                        ),
                      ),
                      onPressed: () {
                        setState(
                          () {
                            _win = false;
                            _amount = [0, 0];
                            _number = 0;
                            game.init();
                          },
                        );
                        winClearController.clear();
                      },
                    ),
                  ),
                  const Divider(),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int i = 0; i < _amount[1] - _amount[0]; i++)
                          ImageBull(),
                        for (int i = 0; i < _amount[0]; i++) ImageCow(),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: _win,
                    child: const Divider(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
