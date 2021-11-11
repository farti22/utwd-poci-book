import 'package:flutter/material.dart';

TabBar TaskTabBar(
  context,
  int amount,
) {
  return TabBar(
    labelColor: Colors.black,
    tabs: List<Widget>.generate(
        amount, (int index) => Tab(text: "Задание ${index + 1}")),
  );
}
