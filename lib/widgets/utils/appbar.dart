import 'package:flutter/material.dart';

AppBar UniAppBar(
  context, {
  Widget title = const Text("Имя"),
  Widget? leading,
  List<Widget>? actions,
  PreferredSizeWidget? bottom,
}) {
  return AppBar(
    title: title,
    leading: leading,
    actions: actions,
    bottom: bottom,
    backgroundColor: Colors.white,
    foregroundColor: Colors.black87,
    elevation: 0.0,
    centerTitle: true,
  );
}
