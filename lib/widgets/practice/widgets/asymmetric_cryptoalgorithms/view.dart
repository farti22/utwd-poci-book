import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_poci_book/helpers/math.dart';
import 'package:flutter_poci_book/widgets/practice/widgets/asymmetric_cryptoalgorithms/internal.dart';
import 'package:flutter_poci_book/widgets/utils/appbar.dart';
import 'package:flutter_poci_book/widgets/utils/outline_textfield.dart';
import 'package:flutter_poci_book/widgets/utils/snackbar.dart';
import 'package:flutter_poci_book/widgets/utils/tasktabbar.dart';

class AsymmetricCryptoalgorithms extends StatefulWidget {
  const AsymmetricCryptoalgorithms({Key? key}) : super(key: key);

  @override
  _AsymmetricCryptoalgorithmsState createState() =>
      _AsymmetricCryptoalgorithmsState();
}

class _AsymmetricCryptoalgorithmsState
    extends State<AsymmetricCryptoalgorithms> {
  //Task 1
  var _pVal = 0;
  var _qVal = 0;
  var _outputController = TextEditingController();
  var _rsa = RSA();
  var _rsaNumber = 0;
  var _rsaKeysInit = false;
  var _rsaPublicKey = 0;
  var _rsaPrivateKey = 0;

  //Task 2
  var _elgamal = Elgamal();
  var _elgamalText = "";
  var _elgamalP = 0;
  var _elgamalG = 0;
  var _elgamalX = 0;
  var _elgamalController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: UniAppBar(
          context,
          title: const Text("Асинхронные криптоалгоритмы"),
          bottom: TaskTabBar(context, 2),
        ),
        body: TabBarView(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 40.0),
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 9.0),
                          child: OutlinedTextField(
                            labelText: "p",
                            hintText: "Введите p",
                            textInputFormatter: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            onChanged: (text) {
                              setState(() {
                                if (text.isEmpty) _pVal = 0;
                                _pVal = int.parse(text);
                              });
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 9.0),
                          child: OutlinedTextField(
                            labelText: "q",
                            hintText: "Введите q",
                            textInputFormatter: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            onChanged: (text) {
                              setState(() {
                                if (text.isEmpty) _qVal = 0;
                                _qVal = int.parse(text);
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.add_moderator),
                    label: const Text("Сгенерировать ключи"),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(300, 0),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 60.0,
                        vertical: 10.0,
                      ),
                    ),
                    onPressed: isPrime(_pVal) && isPrime(_qVal)
                        ? () {
                            print("p:${this._pVal} q:${this._qVal}");
                            _rsa.keyGen(this._pVal, this._qVal);
                            setState(() {
                              _rsaPublicKey = _rsa.publicKey;
                              _rsaPrivateKey = _rsa.privateKey;
                              _rsaKeysInit = true;
                            });
                          }
                        : null,
                  ),
                  const Divider(),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Public key: ${_rsaPublicKey}",
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "Private key: ${_rsaPrivateKey}",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  OutlinedTextField(
                      textInputFormatter: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      labelText: "Число",
                      hintText: "Введите число",
                      onChanged: (text) {
                        setState(() {
                          _rsaNumber = int.parse(text);
                        });
                      }),
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
                    onPressed: !_rsaKeysInit && _rsaNumber != 0
                        ? null
                        : () {
                            _outputController.text =
                                _rsa.encrypt(_rsaNumber).toString();
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
                    onPressed: !_rsaKeysInit && _rsaNumber != 0
                        ? null
                        : () {
                            _outputController.text =
                                _rsa.decrypt(_rsaNumber).toString();
                          },
                  ),
                  const Divider(),
                  //Поле вывода с кнопкой КОПИРОВАТЬ
                  OutlinedTextField(
                    labelText: "Вывод",
                    hintText: "Вывод",
                    readOnly: true,
                    controller: _outputController,
                    suffixIcon: IconButton(
                      onPressed: () {
                        Clipboard.setData(
                          ClipboardData(text: _outputController.text),
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
                        _elgamalText = text;
                      });
                    },
                  ),
                  const Divider(),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 9.0),
                          child: OutlinedTextField(
                            labelText: "p",
                            hintText: "Введите p",
                            textInputFormatter: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            onChanged: (text) {
                              setState(() {
                                if (text.isEmpty) _elgamalP = 0;
                                _elgamalP = int.parse(text);
                              });
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 9.0, right: 9.0),
                          child: OutlinedTextField(
                            labelText: "g",
                            hintText: "Введите g",
                            textInputFormatter: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            onChanged: (text) {
                              setState(() {
                                if (text.isEmpty) _elgamalG = 0;
                                _elgamalG = int.parse(text);
                              });
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 9.0),
                          child: OutlinedTextField(
                            labelText: "x",
                            hintText: "Введите x",
                            textInputFormatter: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            onChanged: (text) {
                              setState(() {
                                if (text.isEmpty) _elgamalX = 0;
                                _elgamalX = int.parse(text);
                              });
                            },
                          ),
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
                    onPressed: !(isPrime(_elgamalP) &&
                            _elgamalP > _elgamalG &&
                            _elgamalP > _elgamalX)
                        ? null
                        : () {
                            _elgamalController.text = _elgamal.encrypt(
                              _elgamalText,
                              _elgamalP,
                              _elgamalG,
                              _elgamalX,
                            );
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
                    onPressed: !(isPrime(_elgamalP) && _elgamalP > _elgamalX)
                        ? null
                        : () {
                            _elgamalController.text = _elgamal.decrypt(
                              _elgamalText,
                              _elgamalP,
                              _elgamalX,
                            );
                          },
                  ),
                  const Divider(),
                  //Поле вывода с кнопкой КОПИРОВАТЬ
                  OutlinedTextField(
                    labelText: "Вывод",
                    hintText: "Вывод",
                    readOnly: true,
                    controller: _elgamalController,
                    suffixIcon: IconButton(
                      onPressed: () {
                        Clipboard.setData(
                          ClipboardData(text: _elgamalController.text),
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
            )
          ],
        ),
      ),
    );
  }
}
