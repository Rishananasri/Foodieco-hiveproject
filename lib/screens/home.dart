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
  Future<void> logoutUser(BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setBool("isLoggedIn", false);
    await pref.remove("username");
    await pref.remove("password");

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
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                IconButton(
                  onPressed: () async {
                    SharedPreferences pref =
                        await SharedPreferences.getInstance();
                    await pref.setBool("isLoggedIn", false);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const Login()),
                    );
                  },
                  icon: Icon(Icons.logout),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 220, child: CarouselDemo()),
                  const SizedBox(height: 50),
                  category(context),
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
