import 'package:flutter/material.dart';
import 'package:pr/screens/login.dart';
import 'package:pr/widget/carousel-slider.dart';
import 'package:pr/widget/home-widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    _loadCurrentUser();
  }

  // Load the current logged-in username
  Future<void> _loadCurrentUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      currentUser = pref.getString("currentUsername") ?? "";
    });
  }

  // Logout function
  Future<void> logoutUser(BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setBool("isLoggedIn", false);
    await pref.remove("currentUsername");

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Login()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 217, 226, 236),
      body: Column(
        children: [
          const SizedBox(height: 20),
          // Top App Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Image.asset(
                    "assets/images/Foodieco-removebg-preview.png",
                    height: 90,
                    width: 150,
                    fit: BoxFit.contain,
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: PopupMenuButton<String>(
                    icon: const Icon(Icons.more_vert, color: Colors.black),
                    onSelected: (value) {
                      if (value == 'log out') {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text("Log out"),
                            content: const Text(
                              "Are you sure you want to log out?",
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("Cancel"),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  logoutUser(context);
                                },
                                child: const Text(
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
                      const PopupMenuItem<String>(
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
                ),
              ],
            ),
          ),

          // Main Body
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Carousel Slider
                  const SizedBox(height: 220, child: CarouselDemo()),
                  const SizedBox(height: 50),

                  // Categories (pass current user for per-user filtering)
                  category(context, currentUser),

                  const SizedBox(height: 70),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
