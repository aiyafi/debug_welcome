import 'package:flutter/material.dart';

class LoginTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintLoginText;
  final bool hiddenPassword;

  const LoginTextField({
    super.key,
    required this.controller,
    required this.hiddenPassword,
    required this.hintLoginText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: hiddenPassword,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
          color: Color(0xFFE6DDC4),
        )),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
          color: Color(0xFFE6DDC4),
        )),
        fillColor: const Color(0xFFEAE0DA),
        filled: true,
        hintText: hintLoginText,
      ),
    );
  }
}
