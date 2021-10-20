import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OutlinedTextField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final TextEditingController? controller;
  final IconButton? suffixIcon;
  final bool readOnly;
  final List<TextInputFormatter>? textInputFormatter;
  final void Function(String)? onChanged;

  const OutlinedTextField({
    Key? key,
    required this.labelText,
    required this.hintText,
    this.readOnly = false,
    this.onChanged,
    this.controller,
    this.suffixIcon,
    this.textInputFormatter,
  }) : super(key: key);

  _OutlinedTextFieldState createState() => _OutlinedTextFieldState();
}

class _OutlinedTextFieldState extends State<OutlinedTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      onChanged: widget.onChanged,
      readOnly: widget.readOnly,
      inputFormatters: widget.textInputFormatter,
      decoration: InputDecoration(
        labelText: widget.labelText,
        border: const OutlineInputBorder(),
        hintText: widget.hintText,
        suffixIcon: widget.suffixIcon,
      ),
    );
  }
}
