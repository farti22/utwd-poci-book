import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_poci_book/widgets/utils/appbar.dart';
import 'package:flutter_poci_book/widgets/utils/outline_textfield.dart';
import 'package:flutter_poci_book/widgets/utils/snackbar.dart';
import 'package:flutter_poci_book/widgets/utils/tasktabbar.dart';

import 'internal.dart';

class SymmetricEncryption extends StatefulWidget {
  const SymmetricEncryption({Key? key}) : super(key: key);

  @override
  _SymmetricEncryptionState createState() => _SymmetricEncryptionState();
}

class _SymmetricEncryptionState extends State<SymmetricEncryption> {
  // Task1
  var dse = DoubleSwapEncryption();
  String _textDoubleSwap = "";
  int _size = 0;
  List<int> _firstKeys = [0];
  List<int> _secondKeys = [0];
  final _textDoubleSwapController = TextEditingController();
  final _outputDoubleSwapController = TextEditingController();

  //Task2
  var bpe = BasePolybeyEncryption();
  var cpe = ComplicatePolybeyEncryption();
  var pwke = PolybetWithKeyEncryption();
  String _textPolybey = "";
  int _shift = 0;
  String _keyPolybey = "";
  final _outputPolybeyController = TextEditingController();
  bool _viewComplicatePolybey = false;
  bool _viewPolybeyWithKey = false;

  List<int> getKeysFromString(String text) {
    List<int> list = [];
    int temp = int.parse(text);
    while (temp > 0) {
      list.add(temp % 10);
      temp = temp ~/ 10;
    }
    return list;
  }

  void simpleDialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Выберите метод'),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                setState(() {
                  _viewComplicatePolybey = false;
                  _viewPolybeyWithKey = false;
                });
                Navigator.pop(context);
              },
              child: const Text('Базовый'),
            ),
            SimpleDialogOption(
              onPressed: () {
                setState(() {
                  _viewComplicatePolybey = true;
                  _viewPolybeyWithKey = false;
                });
                Navigator.pop(context);
              },
              child: const Text('Усложненный'),
            ),
            SimpleDialogOption(
              onPressed: () {
                setState(() {
                  _viewComplicatePolybey = false;
                  _viewPolybeyWithKey = true;
                });
                Navigator.pop(context);
              },
              child: const Text('С ключом'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: UniAppBar(
          context,
          title: const Text("Симметричное шифрование"),
          bottom: TaskTabBar(context, 2),
        ),
        body: TabBarView(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 40.0),
              padding: const EdgeInsets.symmetric(
                horizontal: 30.0,
                vertical: 10.0,
              ),
              child: Center(
                child: Column(
                  children: [
                    Row(
                      children: [
                        //Форма для ввода фразы для шифрования
                        Expanded(
                          flex: 3,
                          child: Container(
                            padding: const EdgeInsets.only(right: 18.0),
                            child: OutlinedTextField(
                              textInputFormatter: [
                                FilteringTextInputFormatter.allow(
                                    RegExp('[а-яА-Я ]')),
                                LengthLimitingTextInputFormatter(32)
                              ],
                              labelText: "Текст",
                              hintText: "Введите текст", 
                              controller: _textDoubleSwapController,
                              onChanged: (text) {
                                setState(
                                  () {
                                    if (text.length > _size * _size) {
                                      _textDoubleSwapController.text =
                                          _textDoubleSwap;
                                    } else {
                                      _textDoubleSwap = text;
                                    }
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                        //Форма для ввода ключа по Цезарю
                        Expanded(
                          flex: 1,
                          child: OutlinedTextField(
                            textInputFormatter: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            labelText: "Размер",
                            hintText: "-",
                            onChanged: (text) {
                              setState(
                                () {
                                  if (text == "" || text == "0") {
                                    _size = 1;
                                    return;
                                  }
                                  _size = int.parse(text);
                                  if (_textDoubleSwapController.text.length >
                                      _size) {
                                    _textDoubleSwap = _textDoubleSwapController
                                        .text
                                        .substring(0, _size);
                                    _textDoubleSwapController.text =
                                        _textDoubleSwap;
                                  }
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(right: 9),
                            child: OutlinedTextField(
                              textInputFormatter: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              labelText: "Набор ключей #1",
                              hintText: "0",
                              onChanged: (text) {
                                setState(
                                  () {
                                    if (text == "" || text == "0") {
                                      _firstKeys = [1];
                                      return;
                                    }
                                    _firstKeys = getKeysFromString(text);
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(left: 9),
                            child: OutlinedTextField(
                              textInputFormatter: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              labelText: "Набор ключей #2",
                              hintText: "0",
                              onChanged: (text) {
                                setState(
                                  () {
                                    if (text == "" || text == "0") {
                                      _secondKeys = [1];
                                      return;
                                    }
                                    _secondKeys = getKeysFromString(text);
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    //Кнопка ЗАШИФРОВАТЬ
                    // Проверка что символы не повторяются
                    // Проверка что длины равны и соответствуют размеру
                    //
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
                      onPressed: _textDoubleSwap == "" ||
                              _firstKeys == [] ||
                              _secondKeys == [] ||
                              _size == 0
                          ? null
                          : () {
                              dse.setSize(_size);
                              dse.setKeys(_firstKeys, _secondKeys);
                              _outputDoubleSwapController.text =
                                  dse.encrypt(_textDoubleSwap);
                            },
                    ),
                    const Divider(),
                    //Кнопка РАСШИФРОВАТЬ
                    ElevatedButton.icon(
                      icon: const Icon(Icons.vpn_key),
                      label: const Text("Расшифровать"),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(300, 0),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 60.0,
                          vertical: 10.0,
                        ),
                      ),
                      onPressed: _textDoubleSwap == "" ||
                              _firstKeys == [] ||
                              _secondKeys == []
                          ? null
                          : () {
                              dse.setSize(_size);
                              dse.setKeys(_firstKeys, _secondKeys);
                              _outputDoubleSwapController.text =
                                  dse.decrypt(_textDoubleSwap);
                            },
                    ),
                    const Divider(),
                    //Поле вывода с кнопкой КОПИРОВАТЬ
                    OutlinedTextField(
                      labelText: "Вывод",
                      hintText: "Вывод",
                      readOnly: true,
                      controller: _outputDoubleSwapController,
                      suffixIcon: IconButton(
                        onPressed: () {
                          Clipboard.setData(
                            ClipboardData(
                                text: _outputDoubleSwapController.text),
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
            ),
            Container(
              margin: const EdgeInsets.only(top: 40.0),
              padding: const EdgeInsets.symmetric(
                horizontal: 30.0,
                vertical: 10.0,
              ),
              child: Center(
                child: Column(
                  children: [
                    ElevatedButton.icon(
                      icon: const Icon(Icons.add_box),
                      label: const Text("Выбрать метод"),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(300, 0),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 60.0,
                          vertical: 10.0,
                        ),
                      ),
                      onPressed: () {
                        simpleDialog(context);
                      },
                    ),
                    const Divider(),
                    Row(
                      children: [
                        //Форма для ввода фразы для шифрования
                        Expanded(
                          flex: 3,
                          child: Container(
                            padding: _viewComplicatePolybey
                                ? const EdgeInsets.only(right: 18.0)
                                : null,
                            child: OutlinedTextField(
                              textInputFormatter: [
                                FilteringTextInputFormatter.allow(
                                  RegExp('[a-zA-Z]'),
                                ),
                                FilteringTextInputFormatter.deny(
                                  RegExp('[Jj]'),
                                ),
                                LengthLimitingTextInputFormatter(32),
                              ],
                              labelText: "Текст",
                              hintText: "Введите текст",
                              onChanged: (text) {
                                setState(() {
                                  _textPolybey = text.toUpperCase();
                                });
                              },
                            ),
                          ),
                        ),
                        Visibility(
                          visible: _viewComplicatePolybey,
                          child: Expanded(
                            flex: 1,
                            child: OutlinedTextField(
                              textInputFormatter: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              labelText: "Сдвиг",
                              hintText: "1",
                              onChanged: (text) {
                                setState(
                                  () {
                                    if (text == "" || text == "0") {
                                      _shift = 1;
                                      return;
                                    }
                                    _shift = int.parse(text);
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    _viewPolybeyWithKey ? const Divider() : Container(),
                    Visibility(
                      visible: _viewPolybeyWithKey,
                      child: OutlinedTextField(
                        textInputFormatter: [
                          FilteringTextInputFormatter.allow(
                            RegExp('[a-zA-Z]'),
                          ),
                          FilteringTextInputFormatter.deny(
                            RegExp('[Jj]'),
                          ),
                          LengthLimitingTextInputFormatter(32),
                        ],
                        labelText: "Ключ",
                        hintText: "Слово",
                        onChanged: (text) {
                          setState(() {
                            _keyPolybey =
                                text.toUpperCase().split('').toSet().join();
                          });
                        },
                      ),
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
                      onPressed: _textPolybey == "" ||
                              (_viewComplicatePolybey && _shift == 0) ||
                              (_viewPolybeyWithKey && _keyPolybey == 0)
                          ? null
                          : () {
                              if (_viewComplicatePolybey) {
                                _outputPolybeyController.text =
                                    cpe.encrypt(_textPolybey, _shift);
                              }
                              if (_viewPolybeyWithKey) {
                                _outputPolybeyController.text =
                                    pwke.encrypt(_textPolybey, _keyPolybey);
                              } else {
                                _outputPolybeyController.text =
                                    bpe.encrypt(_textPolybey);
                              }
                            },
                    ),
                    const Divider(),
                    //Кнопка РАСШИФРОВАТЬ
                    ElevatedButton.icon(
                      icon: const Icon(Icons.vpn_key),
                      label: const Text("Расшифровать"),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(300, 0),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 60.0,
                          vertical: 10.0,
                        ),
                      ),
                      onPressed: _textPolybey == "" ||
                              (_viewComplicatePolybey && _shift == 0) ||
                              (_viewPolybeyWithKey && _keyPolybey == 0)
                          ? null
                          : () {
                              if (_viewComplicatePolybey) {
                                _outputPolybeyController.text =
                                    cpe.decrypt(_textPolybey, _shift);
                              }
                              if (_viewPolybeyWithKey) {
                                _outputPolybeyController.text =
                                    pwke.decrypt(_textPolybey, _keyPolybey);
                              } else {
                                _outputPolybeyController.text =
                                    bpe.decrypt(_textPolybey);
                              }
                            },
                    ),
                    const Divider(),
                    //Поле вывода с кнопкой КОПИРОВАТЬ
                    OutlinedTextField(
                      labelText: "Вывод",
                      hintText: "Вывод",
                      readOnly: true,
                      controller: _outputPolybeyController,
                      suffixIcon: IconButton(
                        onPressed: () {
                          Clipboard.setData(
                            ClipboardData(text: _outputPolybeyController.text),
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
            ),
          ],
        ),
      ),
    );
  }
}
