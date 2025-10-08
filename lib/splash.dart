import 'package:flutter/material.dart';
import 'package:pr/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    splash();
  }

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
                  Color.fromARGB(130, 217, 179, 255),
                  Color.fromARGB(160, 201, 163, 255),
                  Color.fromARGB(143, 255, 193, 227),
                  Color.fromARGB(124, 255, 163, 197),
                  Color.fromARGB(110, 255, 248, 240),
                  Color.fromARGB(134, 184, 242, 210),
                  Color.fromARGB(149, 168, 230, 207),
                  Color.fromARGB(120, 255, 248, 176),
                  Color.fromARGB(141, 255, 214, 165),
                ],
              ),
            ),
          ),
          Center(child: Image.asset('assets/images/logo (2).png',width: 300,)),
        ],
      ),
    );
  }

  Future splash() async {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    });
  }
}
