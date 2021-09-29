import 'package:flutter/material.dart';
import 'package:flutter_poci_book/presentation/practice.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("PoCI App | Главная")),
        body: const Center(child: Text("Center text")),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: (value) {
            print("Console:$value");
            setState(() => _currentIndex = value);

            switch (value) {
              case 0:
                Navigator.pushNamed(context, "/home");
                break;
              case 1:
                Navigator.pushNamed(context, "/lecture");
                break;
              case 2:
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Practice()));
            }
          },
          items: [
            _bottomNavigationItem("Главная", const Icon(Icons.verified_user)),
            _bottomNavigationItem("Теория", const Icon(Icons.verified_user)),
            _bottomNavigationItem("Практика", const Icon(Icons.verified_user)),
          ],
        ));
  }

  BottomNavigationBarItem _bottomNavigationItem(String text, Icon icon) {
    return BottomNavigationBarItem(
      label: text,
      icon: icon,
    );
  }
}
