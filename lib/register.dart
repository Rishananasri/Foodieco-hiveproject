import 'package:flutter/material.dart';
import 'package:pr/login.dart';
import 'package:pr/widget/bottomnavbar.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _isPasswordHidden = true;
  bool _isConfirmPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: 910,
            width: 420,
            child: Image.asset("assets/images/rg.bg1.png", fit: BoxFit.cover),
          ),
          Center(
            child: Container(
              height: 380,
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
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color.fromARGB(66, 255, 255, 255),
                        border: Border.all(color: Colors.white, width: 1),
                      ),

                      child: TextField(
                        style: TextStyle(color: Colors.white, fontSize: 18),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Username',
                          prefixIcon: Icon(
                            Icons.person,
                            color: const Color.fromARGB(255, 186, 184, 184),
                          ),
                          hintStyle: TextStyle(
                            color: Color.fromARGB(255, 186, 184, 184),
                          ),
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color.fromARGB(66, 255, 255, 255),
                        border: Border.all(color: Colors.white, width: 1),
                      ),

                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              obscureText: _isPasswordHidden,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Password',
                                prefixIcon: Icon(
                                  Icons.lock_outline,
                                  color: const Color.fromARGB(
                                    255,
                                    186,
                                    184,
                                    184,
                                  ),
                                ),
                                hintStyle: TextStyle(
                                  color: Color.fromARGB(255, 186, 184, 184),
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              _isPasswordHidden
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Color.fromARGB(255, 186, 184, 184),
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordHidden = !_isPasswordHidden;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color.fromARGB(66, 255, 255, 255),
                        border: Border.all(color: Colors.white, width: 1),
                      ),

                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              obscureText: _isConfirmPasswordHidden,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Confirm Password',
                                prefixIcon: Icon(
                                  Icons.lock_outline,
                                  color: const Color.fromARGB(
                                    255,
                                    186,
                                    184,
                                    184,
                                  ),
                                ),
                                hintStyle: TextStyle(
                                  color: Color.fromARGB(255, 186, 184, 184),
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              _isConfirmPasswordHidden
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Color.fromARGB(255, 186, 184, 184),
                            ),
                            onPressed: () {
                              setState(() {
                                _isConfirmPasswordHidden =
                                    !_isConfirmPasswordHidden;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Bottomnavbar()),
                      );
                    },
                    child: Container(
                      height: 35,
                      width: 80,
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
                          "Sign in",
                          style: TextStyle(
                            color: Color.fromARGB(255, 186, 184, 184),
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

          Positioned(
            top: 190,
            left: 90,
            child: Image.asset(
              "assets/images/Foodieco-removebg-preview.png",
              height: 50,
            ),
          ),

          Positioned(top: 680, left: 90, child: Text("Don’t have an account?")),
          Positioned(
            top: 680,
            left: 240,
            child: InkWell(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              },
              child: Text(
                "Login",
                style: TextStyle(color: Color.fromARGB(255, 0, 94, 255)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
