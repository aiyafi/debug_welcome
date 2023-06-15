import 'package:flutter/material.dart';

class ButtonLoginPage extends StatelessWidget {
  final VoidCallback onTap;
  final String text;

  const ButtonLoginPage({
    Key? key,
    required this.onTap,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          primary: Color(0xFF142238),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          fixedSize: Size(550, 55), // Atur lebar dan tinggi sesuai kebutuhan Anda
        ),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
