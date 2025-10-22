import 'dart:developer'; 
import 'package:flutter/material.dart';
import 'package:pr/screens/register.dart';
import 'package:pr/widget/bottomnavbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isPasswordHidden = true;
  TextEditingController namecontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
    log("Login Page Initialized", name: "LoginPage");
  }

  @override
  void dispose() {
    namecontroller.dispose();
    passcontroller.dispose();
    log("Login Page Disposed", name: "LoginPage");
    super.dispose();
  }

  void togglePasswordVisibility() {
    setState(() {
      _isPasswordHidden = !_isPasswordHidden;
    });
    log("Password visibility toggled: $_isPasswordHidden", name: "LoginPage");
  }

  Future<void> handleLogin() async {
    String username = namecontroller.text.trim();
    String password = passcontroller.text.trim();
    log("Login attempt with username: $username", name: "LoginPage");

    SharedPreferences pref = await SharedPreferences.getInstance();
    String savedPassword = pref.getString("user_${username}_password") ?? "";
    log("Retrieved saved password for user: $username", name: "LoginPage");

    if (username.isEmpty || password.isEmpty) {
      log("Login failed: Username or password is empty", name: "LoginPage");
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title:  Text("Incomplete Details"),
          content:  Text("Please enter both your username and password."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child:  Text("OK"),
            ),
          ],
        ),
      );
      return;
    }

    if (password == savedPassword && savedPassword.isNotEmpty) {
      log("Login successful for user: $username", name: "LoginPage");

      await pref.setBool("isLoggedIn", true);
      await pref.setString("currentUsername", username);
      await pref.setString("loggedInUser", username);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Bottomnavbar(justLoggedIn: true),
        ),
      );
    } else {
      log(
        "Login failed: Invalid credentials for user: $username",
        name: "LoginPage",
      );
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content:  Text(
            "Invalid credentials. Please login with correct account.",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child:  Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  void navigateToRegister() {
    log("Navigating to Register Page", name: "LoginPage");
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) =>  Register()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Image.asset("assets/images/log.bg.jpeg", fit: BoxFit.cover),
          ),
          Positioned(
            top: 200,
            left: 90,
            child: Image.asset(
              "assets/images/Foodieco-removebg-preview.png",
              height: 50,
            ),
          ),
          Center(
            child: Container(
              height: 350,
              width: 350,
              decoration: BoxDecoration(
                color: const Color.fromARGB(64, 255, 255, 255),
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
                        controller: namecontroller,
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
                   SizedBox(height: 10),
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
                              controller: passcontroller,
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
                   SizedBox(height: 20),
                  TextButton(
                    onPressed: handleLogin,
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
                          "Login",
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
            top: 650,
            left: 90,
            child: Row(
              children: [
                 Text(
                  "Don’t have an account?",
                  style: TextStyle(color: Colors.white),
                ),
                 SizedBox(width: 8),
                InkWell(
                  onTap: navigateToRegister,
                  child:  Text(
                    "Sign up",
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
