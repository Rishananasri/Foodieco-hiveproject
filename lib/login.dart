import 'package:flutter/material.dart';
import 'package:pr/widget/bottomnavbar.dart';

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
                  Color.fromARGB(196, 217, 179, 255),
                  Color.fromARGB(211, 201, 163, 255),
                  Color.fromARGB(216, 255, 193, 227),
                  Color.fromARGB(154, 255, 163, 197),
                  Color.fromARGB(164, 255, 248, 240),
                  Color.fromARGB(217, 184, 242, 210),
                  Color.fromARGB(224, 168, 230, 207),
                  Color.fromARGB(189, 255, 248, 176),
                  Color.fromARGB(215, 255, 214, 165),
                ],
              ),
            ),
          ),
          Center(
            child: Container(
              height: 350,
              width: 350,
              decoration: BoxDecoration(
                color: const Color.fromARGB(112, 255, 255, 255),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(5, 5),
                    blurRadius: 10,
                    color: const Color.fromARGB(32, 0, 0, 0),
                  ),
                ],
              ),
              child: Column(
                children: [
                  SizedBox(height: 60),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color.fromARGB(66, 255, 255, 255),
                        border: Border.all(color: Colors.white, width: 1),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(8, 9),
                            color: const Color.fromARGB(15, 0, 0, 0),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: TextField(
                          style: TextStyle(color: Colors.white, fontSize: 18),
                          decoration: InputDecoration(border: InputBorder.none),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color.fromARGB(66, 255, 255, 255),
                        border: Border.all(color: Colors.white, width: 1),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(8, 9),
                            color: const Color.fromARGB(15, 0, 0, 0),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: TextField(
                          style: TextStyle(color: Colors.white, fontSize: 18),
                          decoration: InputDecoration(border: InputBorder.none),
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Bottomnavbar()),
                      );
                    },
                    child: Container(
                      height: 40,
                      width: 100,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(92, 255, 255, 255),
                        borderRadius: BorderRadius.circular(60),
                        border: Border.all(width: 1, color: Colors.white),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(8, 8),
                            color: const Color.fromARGB(15, 0, 0, 0),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          "Login",
                          style: TextStyle(
                            color: const Color.fromARGB(255, 186, 184, 184),
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
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
