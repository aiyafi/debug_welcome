import 'package:debug_welcome/components/button_login.dart';
import 'package:debug_welcome/components/login_text_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'login_page.dart';

class RegistPageForm extends StatefulWidget {
  const RegistPageForm({super.key});

  @override
  State<RegistPageForm> createState() => _RegistPageFormState();
}

class _RegistPageFormState extends State<RegistPageForm> {
  //Text edit controller
  final nameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  Future _regist() async {
    final response = await http.post(
        Uri.parse('https://10.0.2.2/api_inventaris/register.php'),
        body: {
          "name" : nameTextController.text.toString(),
          "email" : emailTextController.text.toString(),
          "password" : passwordTextController.text.toString(),
        });

    final data = jsonDecode(response.body);
    if(data == "Berhasil") {
      final snackBar = SnackBar(
        content: const Text('Registrasi berhasil! Silakan masuk menggunakan akun yang telah dibuat.'),
        backgroundColor: Colors.green,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginPageForm()),
      );
    } else {
      final snackBar = SnackBar(
        content: const Text('Maaf, akun sudah pernah terdaftar.'),
        backgroundColor: Colors.red,

      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
                //MenRis
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

                //Message
                const Text(
                  "Let's create an account for you",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),

                const SizedBox(
                  height: 35,
                ),

                //Name
                LoginTextField(
                  controller: nameTextController,
                  hiddenPassword: false,
                  hintLoginText: "Name",
                ),

                const SizedBox(
                  height: 15,
                ),

                //Email
                LoginTextField(
                  controller: emailTextController,
                  hiddenPassword: false,
                  hintLoginText: "Email",
                ),

                const SizedBox(
                  height: 15,
                ),

                //PW
                LoginTextField(
                  controller: passwordTextController,
                  hiddenPassword: true,
                  hintLoginText: "Password",
                ),

                const SizedBox(
                  height: 15,
                ),

                //Confirm PW
                // LoginTextField(
                //   controller: confirmPasswordTextController,
                //   hiddenPassword: true,
                //   hintLoginText: "Confirm password",
                // ),

                const SizedBox(
                  height: 55,
                ),

                //Btn
                ButtonLoginPage(
                  onTap: () {
                    _regist();
                    // print("object");
                  },
                  text: "Sign Up",
                ),

                const SizedBox(
                  height: 25,
                ),

                //Sign Up Page
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account?",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginPageForm()),
                        );
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xff132137),
                        ),
                      ),
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
