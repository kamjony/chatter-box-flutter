import 'package:flutter/material.dart';


class MyTextField extends StatelessWidget {
  final String label;
  final TextEditingController textEditingController;
  MyTextField({required this.label, required this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
    );
  }
}
