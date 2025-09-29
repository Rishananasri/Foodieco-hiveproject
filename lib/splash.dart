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
          Positioned(
            top: 350,
            left: 120,
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 239, 49, 185),
                    offset: Offset(5, 5),
                    blurRadius: 10,
                  ),
                ],
                borderRadius: BorderRadius.circular(180),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(180),
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 180,
                  width: 180,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future splash() async {
    Future.delayed(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    });
  }
}
