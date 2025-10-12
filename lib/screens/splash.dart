import 'package:flutter/material.dart';
import 'package:pr/screens/login.dart';
import 'package:pr/screens/register.dart';
import 'package:pr/widget/bottomnavbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigation();
  }

  void navigation() async {
    await Future.delayed(const Duration(seconds: 3));

    SharedPreferences pref = await SharedPreferences.getInstance();
    bool isRegistered = pref.getBool("isRegistered") ?? false;
    bool isLoggedIn = pref.getBool("isLoggedIn") ?? false;

    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Bottomnavbar()),
      );
    } else if (isRegistered) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Login()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Register()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Image.asset(
              "assets/images/download (15).jpeg",
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Image.asset(
              "assets/images/Gemini_Generated_Image_ouit7douit7douit-removebg-preview.png",
              width: 300,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
