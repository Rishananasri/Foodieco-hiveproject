import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:pr/models/recipe_model.dart';
import 'package:pr/views/screens/chart.dart';
import 'package:pr/views/screens/login.dart';
import 'package:pr/views/widget/home-widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String currentUser = "";

  @override
  void initState() {
    super.initState();
    log("Home Page Initialized", name: "HomePage");
    _loadCurrentUser();
  }

  @override
  void dispose() {
    log("Home Page Disposed", name: "HomePage");
    super.dispose();
  }

  Future<void> _loadCurrentUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      currentUser = pref.getString("currentUsername") ?? "";
    });
  }

  Future<void> logoutUser(BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setBool("isLoggedIn", false);
    await pref.remove("currentUsername");

    log("User logged out: $currentUser", name: "HomePage");

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Login()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 217, 226, 236),
      body: Column(
        children: [
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Image.asset(
                    "assets/images/Foodieco-removebg-preview.png",
                    height: 90,
                    width: 150,
                    fit: BoxFit.contain,
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Chart()),
                          );
                        },
                        icon: Icon(Icons.bar_chart_rounded),
                      ),
                      PopupMenuButton<String>(
                        icon: Icon(Icons.more_vert, color: Colors.black),
                        onSelected: (value) {
                          if (value == 'log out') {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text("Log out"),
                                content: Text(
                                  "Are you sure you want to log out?",
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text("Cancel"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      logoutUser(context);
                                    },
                                    child: Text(
                                      "Log out",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                        itemBuilder: (BuildContext context) => [
                          PopupMenuItem<String>(
                            value: 'log out',
                            child: Row(
                              children: [
                                Icon(Icons.logout, color: Colors.red),
                                SizedBox(width: 8),
                                Text('Log out'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 50),
                  FutureBuilder(
                    future: Hive.openBox<RecipeModel>('recipe_db'),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else {
                        return category(context, currentUser);
                      }
                    },
                  ),
                  SizedBox(height: 70),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
