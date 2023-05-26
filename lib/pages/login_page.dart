import 'package:debug_welcome/components/button_login.dart';
import 'package:debug_welcome/components/login_text_field.dart';
import 'package:debug_welcome/pages/signup_page.dart';
import 'package:debug_welcome/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPageForm extends StatefulWidget {
  const LoginPageForm({super.key});

  // void _NavigateDashboardState(BuildContext context) {
  //   Navigator.push(
  //     context, MaterialPageRoute(
  //       builder: (context) => dashboardPage(),
  //     ),
  //   );
  // }

  @override
  State<LoginPageForm> createState() => _LoginPageFormState();
}

class _LoginPageFormState extends State<LoginPageForm> {
  //Text edit controller
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFf7ebe1),
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
                  "Sign in to continue",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),

                const SizedBox(
                  height: 35,
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
                  height: 25,
                ),

                //Btn
                ButtonLoginPage(
                  onTap: () {}, 
                  text: "Sign In"
                ),

                const SizedBox(
                  height: 25,
                ),

                //Sign Up Page
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an acoount?",
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
                        "Register Now",
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
