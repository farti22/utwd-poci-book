import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_poci_book/widgets/practice/widgets/replacement_encrypt/internal.dart';
import 'package:flutter_poci_book/widgets/utils/outline_textfield.dart';
import 'package:flutter_poci_book/widgets/utils/snackbar.dart';
import 'package:flutter_poci_book/widgets/utils/appbar.dart';
import 'package:flutter_poci_book/widgets/utils/tasktabbar.dart';

class ReplacementGenerator extends StatefulWidget {
  const ReplacementGenerator({Key? key}) : super(key: key);

  @override
  _ReplacementGeneratorState createState() => _ReplacementGeneratorState();
}

class _ReplacementGeneratorState extends State<ReplacementGenerator> {
  //Task 1
  final _outputCaesarController = TextEditingController();
  var _textCaesar = "";
  var _keyCaesar = 1;
  //Task 2
  final _outputTrisemusController = TextEditingController();
  var _textTrisemus = "";
  var _keyTrisemus = [1, 1, 1];
  //Task 3
  final _outputPlayfairController = TextEditingController();
  var _textPlayfair = "";
  var _keyPlayfair = "";
  //

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: UniAppBar(
          context,
          title: const Text("Шифрование методами замены"),
          bottom: TaskTabBar(context, 3),
        ),
        body: TabBarView(
          children: [
            Container(
              // First Task
              margin: const EdgeInsets.only(top: 40.0),
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
              child: Center(
                //color: Colors.green.withOpacity(0.1),
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
                                      RegExp('[а-яА-Я]')),
                                ],
                                labelText: "Текст",
                                hintText: "Введите текст",
                                onChanged: (text) {
                                  setState(() {
                                    _textCaesar = text;
                                  });
                                }),
                          ),
                        ),
                        //Форма для ввода ключа по Цезарю
                        Expanded(
                          flex: 1,
                          child: OutlinedTextField(
                            textInputFormatter: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            labelText: "Ключ",
                            hintText: "1",
                            onChanged: (text) {
                              setState(() {
                                if (text == "" || text == "0") {
                                  _keyCaesar = 1;
                                  return;
                                }
                                _keyCaesar = int.parse(text);
                              });
                            },
                          ),
                        ),
                      ],
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
                      onPressed: _textCaesar == "" || _keyCaesar == ""
                          ? null
                          : () {
                              _outputCaesarController.text =
                                  CaesarSystem.encrypt(_textCaesar, _keyCaesar);
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
                      onPressed: _textCaesar == "" || _keyCaesar == ""
                          ? null
                          : () {
                              _outputCaesarController.text =
                                  CaesarSystem.decrypt(_textCaesar, _keyCaesar);
                            },
                    ),
                    const Divider(),
                    //Поле вывода с кнопкой КОПИРОВАТЬ
                    OutlinedTextField(
                      labelText: "Вывод",
                      hintText: "Вывод",
                      readOnly: true,
                      controller: _outputCaesarController,
                      suffixIcon: IconButton(
                        onPressed: () {
                          Clipboard.setData(
                            ClipboardData(text: _outputCaesarController.text),
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
              // Ssecond Task
              margin: const EdgeInsets.only(top: 40.0),
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
              child: Center(
                child: Column(
                  children: [
                    //Форма для ввода фразы для шифрования
                    Container(
                      padding: const EdgeInsets.only(right: 18.0),
                      child: OutlinedTextField(
                          textInputFormatter: [
                            FilteringTextInputFormatter.allow(
                                RegExp('[а-яА-Я]')),
                          ],
                          labelText: "Текст",
                          hintText: "Введите текст",
                          onChanged: (text) {
                            setState(() {
                              _textTrisemus = text;
                            });
                          }),
                    ),
                    //Форма для 3 ключей в шифре Трисемуся
                    const Divider(),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: OutlinedTextField(
                                textInputFormatter: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                labelText: "Ключ 1",
                                hintText: "1",
                                onChanged: (text) {
                                  setState(() {
                                    if (text == "" || text == "0") {
                                      _keyCaesar = 1;
                                      return;
                                    }
                                    _keyTrisemus[0] = int.parse(text);
                                  });
                                }),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: OutlinedTextField(
                                textInputFormatter: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                labelText: "Ключ 2",
                                hintText: "1",
                                onChanged: (text) {
                                  setState(() {
                                    if (text == "" || text == "0") {
                                      _keyCaesar = 1;
                                      return;
                                    }
                                    _keyTrisemus[1] = int.parse(text);
                                  });
                                }),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: OutlinedTextField(
                                textInputFormatter: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                labelText: "Ключ 3",
                                hintText: "1",
                                onChanged: (text) {
                                  setState(() {
                                    if (text == "" || text == "0") {
                                      _keyCaesar = 1;
                                      return;
                                    }
                                    _keyTrisemus[2] = int.parse(text);
                                  });
                                }),
                          ),
                        ),
                      ],
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
                      onPressed: _textTrisemus == "" || _keyTrisemus.isEmpty
                          ? null
                          : () {
                              _outputTrisemusController.text =
                                  TrisemusSystem.encrypt(
                                      _textTrisemus, _keyTrisemus);
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
                      onPressed: _textTrisemus == "" || _keyTrisemus.isEmpty
                          ? null
                          : () {
                              _outputTrisemusController.text =
                                  TrisemusSystem.decrypt(
                                      _textTrisemus, _keyTrisemus);
                            },
                    ),
                    const Divider(),
                    //Поле вывода с кнопкой КОПИРОВАТЬ
                    OutlinedTextField(
                      labelText: "Вывод",
                      hintText: "Вывод",
                      readOnly: true,
                      controller: _outputTrisemusController,
                      suffixIcon: IconButton(
                        onPressed: () {
                          Clipboard.setData(
                            ClipboardData(text: _outputTrisemusController.text),
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
              // Ssecond Task
              margin: const EdgeInsets.only(top: 40.0),
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
              child: Center(
                //color: Colors.green.withOpacity(0.1),
                child: Column(
                  children: [
                    //Форма для ввода фразы для шифрования
                    Container(
                      padding: const EdgeInsets.only(right: 18.0),
                      child: OutlinedTextField(
                        textInputFormatter: [
                          FilteringTextInputFormatter.allow(RegExp('[а-яА-Я]')),
                        ],
                        labelText: "Текст",
                        hintText: "Введите текст",
                        onChanged: (text) {
                          setState(() {
                            _textPlayfair = text;
                          });
                        },
                      ),
                    ),
                    const Divider(),
                    //Форма для ключа в шифре Плейфеира
                    Container(
                      padding: const EdgeInsets.only(right: 18.0),
                      child: OutlinedTextField(
                        textInputFormatter: [
                          FilteringTextInputFormatter.allow(RegExp('[а-яА-Я]')),
                        ],
                        labelText: "Ключ",
                        hintText: "Введите текст",
                        onChanged: (text) {
                          setState(() {
                            _keyPlayfair = text;
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
                      onPressed: _textPlayfair == "" || _keyPlayfair == ""
                          ? null
                          : () {
                              _outputPlayfairController.text =
                                  PlayfairAlgoritm.encrypt(
                                      _textPlayfair, _keyPlayfair);
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
                      onPressed: _textPlayfair == "" || _keyPlayfair == ""
                          ? null
                          : () {
                              _outputPlayfairController.text =
                                  PlayfairAlgoritm.decrypt(
                                      _textPlayfair, _keyPlayfair);
                            },
                    ),
                    const Divider(),
                    //Поле вывода с кнопкой КОПИРОВАТЬ
                    OutlinedTextField(
                      labelText: "Вывод",
                      hintText: "Вывод",
                      readOnly: true,
                      controller: _outputPlayfairController,
                      suffixIcon: IconButton(
                        onPressed: () {
                          Clipboard.setData(
                            ClipboardData(text: _outputPlayfairController.text),
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
