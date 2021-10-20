import 'package:flutter/material.dart';

void SnackBarMessage(context,
    {Color color = Colors.black87, String message = "Сообщение"}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: color,
      content: Text(message),
    ),
  );
}
