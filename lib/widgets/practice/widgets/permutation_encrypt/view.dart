import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_poci_book/helpers/pair.dart';
import 'package:flutter_poci_book/widgets/practice/widgets/permutation_encrypt/internal.dart';
import 'package:flutter_poci_book/widgets/utils/outline_textfield.dart';
import 'package:flutter_poci_book/widgets/utils/snackbar.dart';
import 'package:flutter_poci_book/widgets/utils/appbar.dart';

class PermutationEncrypt extends StatefulWidget {
  const PermutationEncrypt({Key? key}) : super(key: key);
  @override
  _PermutationEncryptState createState() => _PermutationEncryptState();
}

class _PermutationEncryptState extends State<PermutationEncrypt> {
  //Task 1
  var encTable = EncryptionTable();
  final _outpuEncController = TextEditingController();
  var _text = "";
  //Task 2
  var magicSquare = MagicSquare();
  var _textSquare = "";
  final _outputSquareController = TextEditingController();
  var _size = 5;
  var _key = 1;
  //
  @override
  void initState() {
    super.initState();
    encTable.keys = encTable.availableKeys[0];
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: UniAppBar(
          context,
          title: const Text("Шифрование методами перестановки"),
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
              // First Task ()
              margin: const EdgeInsets.only(top: 40.0),
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: OutlinedTextField(
                          labelText: "Текст",
                          hintText: "Введите текст",
                          onChanged: (text) {
                            setState(() {
                              _text = text;
                              encTable.setAvailableKeys(text.length);
                              encTable.keys = encTable.availableKeys[0];
                              print(
                                  "$_text | ${encTable.availableKeys} | ${encTable.keys}");
                            });
                          },
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            //iconSize: 2.0,
                            icon: const Icon(Icons.vpn_key_outlined),
                            isExpanded: true,
                            value: encTable.availableKeys.isEmpty
                                ? null
                                : encTable.keys,
                            onChanged: (Pair<int, int>? newValue) {
                              setState(() {
                                encTable.keys = newValue!;
                                print(encTable.keys);
                              });
                            },
                            items: encTable.availableKeys
                                .map<DropdownMenuItem<Pair<int, int>>>(
                              (Pair<int, int> pair) {
                                return DropdownMenuItem<Pair<int, int>>(
                                  value: pair,
                                  child: Center(
                                    child: Text(pair.toString()),
                                  ),
                                );
                              },
                            ).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
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
                    onPressed: encTable.checkEmptyKeys()
                        ? null
                        : () {
                            print(encTable.keys);
                            _outpuEncController.text = encTable.encrypt(_text);
                          },
                  ),
                  const Divider(),
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
                    onPressed: encTable.checkEmptyKeys()
                        ? null
                        : () {
                            _outpuEncController.text = encTable.decrypt(_text);
                          },
                  ),
                  const Divider(),
                  OutlinedTextField(
                    labelText: "Вывод",
                    hintText: "Вывод",
                    readOnly: true,
                    controller: _outpuEncController,
                    suffixIcon: IconButton(
                      onPressed: () {
                        Clipboard.setData(
                          ClipboardData(text: _outpuEncController.text),
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
                        _textSquare = text;
                        print("$_textSquare");
                      });
                    },
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 100,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            icon: const Icon(Icons.window_rounded),
                            isExpanded: true,
                            value: _size,
                            onChanged: (int? value) {
                              setState(() {
                                _size = value!;
                                magicSquare.setSize(_size);
                              });
                            },
                            items: const <DropdownMenuItem<int>>[
                              DropdownMenuItem(
                                child: Text("5"),
                                value: 5,
                              ),
                              DropdownMenuItem(
                                child: Text("6"),
                                value: 6,
                              ),
                            ],
                          ),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      Container(
                        width: 100,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            icon: const Icon(Icons.select_all),
                            isExpanded: true,
                            value: _key,
                            onChanged: (int? value) {
                              setState(() {
                                _key = value!;
                                magicSquare.setKey(_key);
                              });
                            },
                            items: const <DropdownMenuItem<int>>[
                              DropdownMenuItem(
                                child: Text("1"),
                                value: 1,
                              ),
                              DropdownMenuItem(
                                child: Text("2"),
                                value: 2,
                              ),
                              DropdownMenuItem(
                                child: Text("3"),
                                value: 3,
                              ),
                            ],
                          ),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
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
                    onPressed: _textSquare.isEmpty
                        ? null
                        : () {
                            _outputSquareController.text =
                                magicSquare.encrypt(_textSquare);
                          },
                  ),
                  const Divider(),
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
                    onPressed: _textSquare.isEmpty
                        ? null
                        : () {
                            _outputSquareController.text =
                                magicSquare.decrypt(_textSquare);
                          },
                  ),
                  const Divider(),
                  OutlinedTextField(
                    labelText: "Вывод",
                    hintText: "Вывод",
                    readOnly: true,
                    controller: _outputSquareController,
                    suffixIcon: IconButton(
                      onPressed: () {
                        Clipboard.setData(
                          ClipboardData(text: _outputSquareController.text),
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
