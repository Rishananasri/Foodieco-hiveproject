import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:pr/widget/bottomnavbar.dart';
import 'package:pr/widget/login-widgets.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(196, 120, 90, 180),
                  Color.fromARGB(211, 100, 80, 160),
                  Color.fromARGB(216, 150, 100, 140),
                  Color.fromARGB(154, 130, 90, 120),
                  Color.fromARGB(164, 180, 140, 160),
                  Color.fromARGB(217, 139, 185, 157),
                  Color.fromARGB(223, 129, 191, 170),
                  Color.fromARGB(189, 180, 180, 100),
                  Color.fromARGB(215, 200, 160, 120),
                ],
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GlassTextField(hintText: 'Username'),
                  SizedBox(height: 20),
                  GlassTextField(hintText: 'Password', isPassword: true),
                  SizedBox(height: 30),
                  GlassButton(
                    text: 'Login',
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Bottomnavbar()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
