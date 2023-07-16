import 'package:flutter/material.dart';

class MyBuilderForm extends StatelessWidget {
  final String name;
  final IconData icon;
  final TextEditingController controller;
  final TextInputType inputType;

  const MyBuilderForm({
    super.key,
    required this.name,
    required this.icon,
    required this.controller,
    required this.inputType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFB70404),
            width: 3.0,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFB70404),
            width: 3.0,
          ),
        ),
        hintText: name,
        hintStyle: const TextStyle(
          color: Color(0xFFB70404),
        ),
        prefixIcon: Icon(
          icon,
          color: const Color(0xFFB70404),
        ),
        filled: true,
        fillColor: const Color(0xFFB70404).withOpacity(0.20),
      ),
      cursorColor: const Color(0xFFB70404),
      controller: controller,
      keyboardType: inputType,
      textInputAction: TextInputAction.next,
      style: const TextStyle(
        color: Color(0xFFB70404),
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
