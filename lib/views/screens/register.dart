import 'dart:developer'; 
import 'package:flutter/material.dart';
import 'package:pr/views/screens/login.dart';
import 'package:pr/views/widget/bottomnavbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _isPasswordHidden = true;
  bool _isConfirmPasswordHidden = true;

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();

  @override
  void initState() {
    super.initState();
    log("Register Page Initialized", name: "RegisterPage");
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    log("Register Page Disposed", name: "RegisterPage");
    super.dispose();
  }

  void togglePasswordVisibility() {
    setState(() {
      _isPasswordHidden = !_isPasswordHidden;
    });
    log(
      "Password visibility toggled: $_isPasswordHidden",
      name: "RegisterPage",
    );
  }

  void toggleConfirmVisibility() {
    setState(() {
      _isConfirmPasswordHidden = !_isConfirmPasswordHidden;
    });
    log(
      "Confirm Password visibility toggled: $_isConfirmPasswordHidden",
      name: "RegisterPage",
    );
  }

  Future<void> handleRegister() async {
    String username = usernameController.text.trim();
    String password = passwordController.text.trim();
    String confirm = confirmController.text.trim();

    log("Registration attempt for username: $username", name: "RegisterPage");

    if (username.isEmpty || password.isEmpty || confirm.isEmpty) {
      log("Registration failed: incomplete details", name: "RegisterPage");
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title:  Text("Incomplete Details"),
          content:  Text("Please enter all details."),
          actions: [
            TextButton(
              child:  Text("OK"),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
      return;
    }

    if (password != confirm) {
      log("Registration failed: passwords do not match", name: "RegisterPage");
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content:  Text("Passwords do not match. Please try again."),
          actions: [
            TextButton(
              child:  Text("OK"),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
      return;
    }

    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("user_${username}_password", password);
    await pref.setString("currentUsername", username);
    await pref.setBool("isLoggedIn", true);

    log(
      "Registration successful for username: $username",
      name: "RegisterPage",
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Bottomnavbar(justLoggedIn: true)),
    );
  }

  void navigateToLogin() {
    log("Navigating to Login Page", name: "RegisterPage");
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) =>  Login()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: 925,
            width: 420,
            child: Image.asset("assets/images/log.bg.jpeg", fit: BoxFit.cover),
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
                    padding:  EdgeInsets.symmetric(
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
                      child: TextField(
                        controller: usernameController,
                        style:  TextStyle(
                          color: Color.fromARGB(255, 60, 60, 60),
                          fontSize: 18,
                        ),
                        decoration:  InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Username',
                          prefixIcon: Icon(
                            Icons.person,
                            color: Color.fromARGB(255, 158, 157, 157),
                          ),
                          hintStyle: TextStyle(
                            color: Color.fromARGB(255, 158, 157, 157),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.symmetric(
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
                              controller: passwordController,
                              obscureText: _isPasswordHidden,
                              style:  TextStyle(
                                color: Color.fromARGB(255, 60, 60, 60),
                                fontSize: 18,
                              ),
                              decoration:  InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Password',
                                prefixIcon: Icon(
                                  Icons.lock_outline,
                                  color: Color.fromARGB(255, 158, 157, 157),
                                ),
                                hintStyle: TextStyle(
                                  color: Color.fromARGB(255, 158, 157, 157),
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              _isPasswordHidden
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: const Color.fromARGB(255, 158, 157, 157),
                            ),
                            onPressed: togglePasswordVisibility,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.symmetric(
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
                              controller: confirmController,
                              obscureText: _isConfirmPasswordHidden,
                              style:  TextStyle(
                                color: Color.fromARGB(255, 60, 60, 60),
                                fontSize: 18,
                              ),
                              decoration:  InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Confirm Password',
                                prefixIcon: Icon(
                                  Icons.lock_outline,
                                  color: Color.fromARGB(255, 158, 157, 157),
                                ),
                                hintStyle: TextStyle(
                                  color: Color.fromARGB(255, 158, 157, 157),
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              _isConfirmPasswordHidden
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: const Color.fromARGB(255, 158, 157, 157),
                            ),
                            onPressed: toggleConfirmVisibility,
                          ),
                        ],
                      ),
                    ),
                  ),
                   SizedBox(height: 10),
                  TextButton(
                    onPressed: handleRegister,
                    child: Container(
                      height: 35,
                      width: 80,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(92, 255, 255, 255),
                        borderRadius: BorderRadius.circular(60),
                        border: Border.all(width: 1, color: Colors.white),
                        boxShadow:  [
                          BoxShadow(
                            offset: Offset(8, 8),
                            color: Color.fromARGB(15, 0, 0, 0),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child:  Center(
                        child: Text(
                          "Sign in",
                          style: TextStyle(
                            color: Color.fromARGB(255, 64, 64, 64),
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
          Positioned(
            top: 680,
            left: 90,
            child: Row(
              children: [
                 Text(
                  "Already have an account?",
                  style: TextStyle(color: Colors.white),
                ),
                 SizedBox(width: 8),
                InkWell(
                  onTap: navigateToLogin,
                  child:  Text(
                    "Login",
                    style: TextStyle(color: Color.fromARGB(255, 125, 173, 255)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
