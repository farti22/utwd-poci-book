import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_poci_book/widgets/practice/widgets/password_gen/internal.dart';
import 'package:flutter_poci_book/widgets/utils/outline_textfield.dart';
import 'package:flutter_poci_book/widgets/utils/snackbar.dart';
import 'package:flutter_poci_book/widgets/utils/appbar.dart';
import 'package:flutter_poci_book/widgets/utils/tasktabbar.dart';

class PasswordGeneratorView extends StatefulWidget {
  const PasswordGeneratorView({Key? key}) : super(key: key);

  @override
  _PracticeGeneratorViewState createState() => _PracticeGeneratorViewState();
}

class _PracticeGeneratorViewState extends State<PasswordGeneratorView> {
  //Task 1
  double _currentSliderValue = 6;
  String _currentAlphabet = "";
  String _generatedPassword = "";

  //Task 2

  int _count = 1;
  var passwordController = TextEditingController();
  List<String?> _passwordMap = <String?>["абс"];
  final List<String> alph = <String>[
    "абс",
    "АБС",
    "abc",
    "ABC",
    "123",
    "#\$*",
    "FUNC",
  ];
  String? _generatedPasswordWithMap = "";
  String? _keyWord = "";
  var passwordWithMapController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: UniAppBar(
          context,
          title: const Text("Генератор паролей"),
          bottom: TaskTabBar(context, 2),
        ),
        body: TabBarView(
          children: [
            Container(
              // First Task (Password generator)
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
              child: Center(
                //color: Colors.green.withOpacity(0.1),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    OutlinedTextField(
                      labelText: "Словарь",
                      hintText: "Введите символы для пароля",
                      onChanged: (text) {
                        setState(() {
                          _currentAlphabet = text;
                        });
                      },
                    ),
                    Column(
                      children: [
                        const Text(
                          "Длина",
                          style: TextStyle(fontSize: 18),
                        ),
                        Slider(
                          value: _currentSliderValue,
                          min: 6,
                          max: 36,
                          divisions: 28,
                          label: _currentSliderValue.round().toString(),
                          onChanged: (double value) {
                            setState(() {
                              _currentSliderValue = value;
                            });
                          },
                        ),
                      ],
                    ),
                    const Divider(),
                    ElevatedButton.icon(
                      /// Button Password Generator
                      icon: const Icon(Icons.games_rounded),
                      label: const Text("Сгенерировать"),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 60.0,
                          vertical: 10.0,
                        ),
                      ),

                      onPressed: () {
                        if (_currentAlphabet.length > 5) {
                          setState(() {
                            _generatedPassword = PasswordGenerator.generate(
                              _currentSliderValue,
                              _currentAlphabet,
                            );
                          });
                          passwordController.text = _generatedPassword;
                        } else {
                          SnackBarMessage(
                            context,
                            color: Colors.red,
                            message: "Словарь слишком короткий",
                          );
                        }
                      },
                    ),
                    const Divider(),
                    OutlinedTextField(
                      labelText: "Пароль",
                      hintText: "Пароль",
                      readOnly: true,
                      controller: passwordController,
                      suffixIcon: IconButton(
                        onPressed: () {
                          Clipboard.setData(
                            ClipboardData(text: _generatedPassword),
                          ).then(
                            (_) {
                              SnackBarMessage(
                                context,
                                message: "Пароль скопирован в буфер обмена",
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
            // Second Task (Password generator map)
            Container(
              margin: const EdgeInsets.only(top: 40.0),
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
              child: Column(
                children: [
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Container(
                          padding: const EdgeInsets.only(right: 18.0),
                          child: OutlinedTextField(
                            labelText: "Слово",
                            hintText: "Введите ключевое слово",
                            onChanged: (text) {
                              setState(() {
                                print("text [${text}]");
                                _keyWord = text;
                              });
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: OutlinedTextField(
                          labelText: "Длина",
                          hintText: "1",
                          textInputFormatter: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(2),
                          ],
                          onChanged: (text) {
                            setState(() {
                              print("text [${text}]");
                              if (text == "" || text == "0") {
                                _count = 1;
                                return;
                              }
                              _count = int.parse(text);
                              _passwordMap =
                                  List.generate(_count, (index) => alph[0]);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20.0),
                    height: 90.0,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: _count,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: const EdgeInsets.all(10.0),
                          width: 70.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.blue.shade400,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              iconSize: 0.0,
                              isExpanded: true,
                              value: _passwordMap[index],
                              onChanged: (String? newValue) {
                                setState(() {
                                  _passwordMap[index] = newValue;
                                  print(_passwordMap);
                                });
                              },
                              items: alph.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Center(
                                    child: Text(value),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        );
                      },
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  Divider(),
                  ElevatedButton.icon(
                    /// Button Password Generator
                    icon: const Icon(Icons.games_rounded),
                    label: const Text("Сгенерировать"),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 60.0,
                        vertical: 10.0,
                      ),
                    ),

                    onPressed: () {
                      if (_keyWord!.isNotEmpty) {
                        setState(() {
                          var psm = PasswordSegmentMapper(
                              _passwordMap, _keyWord!.length);
                          _generatedPasswordWithMap =
                              PasswordGenerator.generateWithMap(map: psm);
                        });
                        passwordWithMapController.text =
                            _generatedPasswordWithMap!;
                      } else {
                        SnackBarMessage(
                          context,
                          color: Colors.red,
                          message: "Ключевое слово отсутствует",
                        );
                      }
                    },
                  ),
                  const Divider(),
                  OutlinedTextField(
                    labelText: "Пароль",
                    hintText: "Пароль",
                    readOnly: true,
                    controller: passwordWithMapController,
                    suffixIcon: IconButton(
                      onPressed: () {
                        Clipboard.setData(
                          ClipboardData(text: _generatedPasswordWithMap),
                        ).then(
                          (_) {
                            SnackBarMessage(
                              context,
                              message: "Пароль скопирован в буфер обмена",
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
