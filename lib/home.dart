import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(196, 217, 179, 255),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(226, 227, 198, 255),
        title: SizedBox(
          width: 150,
          height: 150,
          child: Image.asset(
            "assets/images/logoname-removebg-preview.png",
            fit: BoxFit.contain,
          ),
        ),
      ),
      body: Column(children: []),
    );
  }
}
