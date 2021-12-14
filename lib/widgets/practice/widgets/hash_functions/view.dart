import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:flutter_poci_book/helpers/math.dart';
import 'package:flutter_poci_book/widgets/utils/appbar.dart';
import 'package:flutter_poci_book/widgets/utils/outline_textfield.dart';
import 'package:flutter_poci_book/widgets/utils/snackbar.dart';
import 'package:flutter_poci_book/widgets/utils/tasktabbar.dart';

import 'internal.dart';

class HashFunction extends StatefulWidget {
  const HashFunction({Key? key}) : super(key: key);
  @override
  _HashFunctionState createState() => _HashFunctionState();
}

class _HashFunctionState extends State<HashFunction> {
  //Task1
  late int _prime1 = 0;
  late int _prime2 = 0;
  late int _alicePrivate = 0;
  late int _bobPrivate = 0;
  int? _aliceSessionKey = null;
  int? _bobSessionKey = null;

  //Task2
  var _outputMD5Controller = TextEditingController();
  var _textMD5 = "";

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: UniAppBar(
          context,
          title: const Text("Хэширование"),
          bottom: TaskTabBar(context, 2),
        ),
        body: TabBarView(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 35.0),
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
              child: Column(
                children: [
                  Table(
                    border: TableBorder(
                      horizontalInside: BorderSide(
                          width: 1,
                          color: Colors.grey.shade300,
                          style: BorderStyle.solid),
                      verticalInside: BorderSide(
                          width: 1,
                          color: Colors.grey.shade300,
                          style: BorderStyle.solid),
                    ),
                    children: <TableRow>[
                      TableRow(
                        children: <Widget>[
                          Container(
                            child: const Text(
                              "Alice",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            margin: const EdgeInsets.all(10),
                          ),
                          Container(
                            child: const Text(
                              "Bob",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            margin: const EdgeInsets.all(10),
                          ),
                        ],
                      ),
                      TableRow(
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(
                                right: 10, bottom: 20, top: 20),
                            child: OutlinedTextField(
                              textInputFormatter: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              labelText: "Приватный",
                              hintText: "Ключ",
                              onChanged: (text) {
                                setState(() {
                                  if (text == "" || text == "0") {
                                    _alicePrivate = 1;
                                    return;
                                  }
                                  _alicePrivate = int.parse(text);
                                });
                              },
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                left: 10, bottom: 20, top: 20),
                            child: OutlinedTextField(
                              textInputFormatter: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              labelText: "Приватный",
                              hintText: "Ключ",
                              onChanged: (text) {
                                setState(() {
                                  if (text == "" || text == "0") {
                                    _bobPrivate = 1;
                                    return;
                                  }
                                  _bobPrivate = int.parse(text);
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(
                                right: 10, bottom: 20, top: 20),
                            child: OutlinedTextField(
                              textInputFormatter: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              labelText: "P",
                              hintText: "Простое число",
                              onChanged: (text) {
                                setState(() {
                                  if (text == "" ||
                                      text == "0" ||
                                      text == "1") {
                                    _prime1 = 2;
                                    return;
                                  }
                                  _prime1 = int.parse(text);
                                });
                              },
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                left: 10, bottom: 20, top: 20),
                            child: OutlinedTextField(
                              textInputFormatter: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              labelText: "G",
                              hintText: "Простое число",
                              onChanged: (text) {
                                setState(() {
                                  if (text == "" ||
                                      text == "0" ||
                                      text == "1") {
                                    _prime2 = 2;
                                    return;
                                  }
                                  _prime2 = int.parse(text);
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Divider(),
                  //Кнопка РАСШИФРОВАТЬ
                  ElevatedButton.icon(
                    icon: const Icon(Icons.search),
                    label: const Text("Определить"),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(300, 0),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 60.0,
                        vertical: 10.0,
                      ),
                    ),
                    onPressed: (!isPrime(_prime1) || !isPrime(_prime2))
                        ? null
                        : () {
                            setState(
                              () {
                                var conn =
                                    DiffieHelmanConnector(_prime1, _prime2);
                                var _alice =
                                    DiffieHelmanUser(_alicePrivate, conn, true);
                                var _bob =
                                    DiffieHelmanUser(_bobPrivate, conn, false);
                                _aliceSessionKey = _alice.getSessionKey();
                                _bobSessionKey = _bob.getSessionKey();
                              },
                            );
                          },
                  ),
                  const Divider(),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Ключ Алисы: ${_aliceSessionKey ?? ""}",
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "Ключ Боба: ${_bobSessionKey ?? ""}",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  Visibility(
                    visible:
                        (_bobSessionKey != null || _aliceSessionKey != null),
                    child: Text(
                      _aliceSessionKey == _bobSessionKey
                          ? "Совпадает"
                          : "Не совпадает",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: _aliceSessionKey == _bobSessionKey
                            ? Colors.green
                            : Colors.red,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 40.0),
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
              child: Column(
                children: [
                  OutlinedTextField(
                    labelText: "Текст",
                    hintText: "Введите текст",
                    onChanged: (text) {
                      setState(() {
                        _textMD5 = text;
                      });
                    },
                  ),
                  const Divider(),
                  //Кнопка ЗАШИФРОВАТЬ
                  ElevatedButton.icon(
                    icon: const Icon(Icons.lock),
                    label: const Text("Зашифровать"),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(300, 0),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 60.0,
                        vertical: 10.0,
                      ),
                    ),
                    onPressed: _textMD5 == ""
                        ? null
                        : () {
                            var _MD5 = new MD5();
                            _outputMD5Controller.text = _MD5.decrypt(_textMD5);
                          },
                  ),
                  const Divider(),
                  //Поле вывода с кнопкой КОПИРОВАТЬ
                  OutlinedTextField(
                    labelText: "Вывод",
                    hintText: "Вывод",
                    readOnly: true,
                    controller: _outputMD5Controller,
                    suffixIcon: IconButton(
                      onPressed: () {
                        Clipboard.setData(
                          ClipboardData(text: _outputMD5Controller.text),
                        ).then(
                          (_) {
                            SnackBarMessage(
                              context,
                              message:
                                  "Изменённый текст скопирован в буфер обмена",
                            );
                          },
                        );
                      },
                      icon: const Icon(Icons.copy),
                    ),
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
