import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_poci_book/widgets/practice/widgets/password_gen/internal.dart';

class PasswordGeneratorView extends StatefulWidget {
  const PasswordGeneratorView({Key? key}) : super(key: key);

  @override
  _PracticeGeneratorViewState createState() => _PracticeGeneratorViewState();
}

class _PracticeGeneratorViewState extends State<PasswordGeneratorView> {
  double _currentSliderValue = 6;
  String _currentAlphabet = "";
  String _generatedPassword = "";
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          // Вынести в отдельный виджет для работы с аппбаром без тени
          title: const Text("Генератор паролей"),
          elevation: 0.0,
          centerTitle: true,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
              child: Center(
                //color: Colors.green.withOpacity(0.1),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    TextField(
                      onChanged: (text) {
                        setState(() {
                          _currentAlphabet = text;
                        });
                      },
                      decoration: const InputDecoration(
                        labelText: "Словарь",
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(),
                        hintText: "Введите символы для пароля",
                      ),
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
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: Colors.red,
                              content: Text("Словарь сликом короткий"),
                            ),
                          );
                        }
                      },
                    ),
                    const Divider(),
                    TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: "Пароль",
                        border: OutlineInputBorder(),
                        hintText: "Введите символы для пароля",
                        suffixIcon: IconButton(
                          onPressed: () {
                            Clipboard.setData(
                              ClipboardData(text: _generatedPassword),
                            ).then(
                              (_) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        "Пароль скопирован в буфер обмена"),
                                  ),
                                );
                              },
                            );
                          },
                          icon: const Icon(Icons.copy),
                        ),
                      ),
                      readOnly: true,
                    ),
                  ],
                ),
              ),
            ),
            const Text("test"),
          ],
        ),
      ),
    );
  }
}
