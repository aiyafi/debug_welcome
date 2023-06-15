import 'package:debug_welcome/components/button_login.dart';
import 'package:debug_welcome/components/login_text_field.dart';
import 'package:debug_welcome/pages/dasboard_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
  final confirmPasswordTextController = TextEditingController();

  void _NavigateLoginOnRegistState(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const DashboardPage()),
    );
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
                LoginTextField(
                  controller: confirmPasswordTextController,
                  hiddenPassword: true,
                  hintLoginText: "Confirm password",
                ),

                const SizedBox(
                  height: 55,
                ),

                //Btn
                ButtonLoginPage(
                  onTap: () {
                    _NavigateLoginOnRegistState(context);
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
                      onTap: () {},
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
