import 'package:flutter/material.dart';
import 'package:vubayu/components/my_button.dart';
import 'package:vubayu/components/my_text_field.dart';
import 'package:vubayu/components/square_tile.dart';
import 'home.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  
  // Controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A282F),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget> [
                const SizedBox(height: 50),
                // logo
                Image.asset(
                  'assets/signlogo.png',
                  width: 70,
                  height: 70,
                ),
                const SizedBox(height: 10),
                //Namaste
                const Text('Namaste',
                  style: TextStyle(color: Color(0xFF00FFBC), fontSize: 24, fontFamily: 'Quicksand')),
                const SizedBox(height: 5),
                //welcome,back
                const Text('welcome back to the app',
                  style: TextStyle(color: Color(0xFF00FFBC), fontSize: 16, fontFamily: 'Quicksand')),
                const SizedBox(height: 20),
                //username_textfield
                MyTextField(
                  controller: usernameController,
                  hintText: 'Your Username',
                  obscureText: false,
                  prefixIcon: Icon(LineAwesomeIcons.user, color: Color(0xFF00FFBC), size: 20),
                ),
                const SizedBox(height: 10),
                //password_textfield
                MyTextField(
                  controller: passwordController,
                  hintText: 'Your Password',
                  obscureText: true,
                  prefixIcon: Icon(LineAwesomeIcons.lock_solid, color: Color(0xFF00FFBC), size: 20),
                ),
                const SizedBox(height: 10),
                //forgot_password
                const Text('Forgot Password?',
                  style: TextStyle(color: Color(0xFF00FFBC), fontSize: 15, fontFamily: 'Quicksand')),
                const SizedBox(height: 20),
                //sign_in_button
                MyButton(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MyHomePage(title: 'Vubayu',)),
                    );
                  },
                ),
                const SizedBox(height: 40),
                //or_continue_with
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Color(0xFF5888a0),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25.0),
                        child: Text('or continue with',
                          style: TextStyle(color: Color(0xFF00FFBC), fontSize: 15, fontFamily: 'Quicksand'),),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Color(0xFF5888a0),
                        ),
                      ),
                    ],
                  )
                ),
                const SizedBox(height: 30),
                // google + apple sign in methods
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SquareTile(imagePath: 'assets/google.png'),
                    SizedBox(width: 25),
                    SquareTile(imagePath: 'assets/apple.png'),
                  ],
                ),
                const SizedBox(height: 40),
                // not a member? register now
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member?',
                      style: TextStyle(color: Color(0xFF009971)),
                    ),
                    SizedBox(width: 6),
                    Text(
                      'Register now',
                      style: TextStyle(
                        color: Color(0xFF00FFBC),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              ]
            ),
          ),
        )
      )
    );
  }
}