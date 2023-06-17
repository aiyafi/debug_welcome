import 'package:debug_welcome/components/button_login.dart';
import 'package:debug_welcome/components/login_text_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '/pages/dasboard_page.dart';
import 'signup_page.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class LoginPageForm extends StatefulWidget {
  const LoginPageForm({Key? key});

  @override
  State<LoginPageForm> createState() => _LoginPageFormState();
}

class _LoginPageFormState extends State<LoginPageForm> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  String email = "";

  // void _navigateToDashboard(BuildContext context) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => const DashboardPage()),
  //   );
  // }

  Future _login() async {
    final response = await http.post(
        Uri.parse('https://192.168.1.7/api_inventaris/login.php'),
        body: {
          "email" : emailTextController.text.toString(),
          "password" : passwordTextController.text.toString(),
        });

    final data = jsonDecode(response.body);
    if(data == "Error") {
      final snackBar = SnackBar(
        content: const Text('Maaf email atau salah!!!'),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      email = emailTextController.text;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DashboardPage(user: email,)),
      );
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFf7ebe1),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "MenRis",
                  style: GoogleFonts.poppins(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Sign in to continue",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                LoginTextField(
                  controller: emailTextController,
                  hiddenPassword: false,
                  hintLoginText: "Email",
                ),
                const SizedBox(
                  height: 15,
                ),
                LoginTextField(
                  controller: passwordTextController,
                  hiddenPassword: true,
                  hintLoginText: "Password",
                ),
                const SizedBox(
                  height: 25,
                ),
                ButtonLoginPage(
                  onTap: () {
                    _login();
                  },
                  text: "Sign In",
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    GestureDetector(
                      child: const Text(
                        "Register Now",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xff132137),
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      }
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
