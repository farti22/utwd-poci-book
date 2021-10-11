import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class OutlinedTextField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final void Function(String)? onChanged;

  const OutlinedTextField({
    Key? key,
    required this.labelText,
    required this.hintText,
    required this.onChanged,
  }) : super(key: key);

  _OutlinedTextFieldState createState() => _OutlinedTextFieldState();
}

class _OutlinedTextFieldState extends State<OutlinedTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        labelText: widget.labelText,
        border: const OutlineInputBorder(),
        hintText: widget.hintText,
      ),
    );
  }
}
