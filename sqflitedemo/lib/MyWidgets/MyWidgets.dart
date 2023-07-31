import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  MyTextField({
    super.key,
    required this.txt,
    required this.labelText,
  });
  String labelText = "";
  final TextEditingController txt;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.white),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.white)
          ),

          labelStyle: TextStyle(
            color: Colors.white,
          ),

          labelText: labelText,
        ),
        controller: txt,
      ),
    );
  }
}

TextStyle buildTextStyle() {
  return TextStyle(
    color: Colors.white,

  );
}
