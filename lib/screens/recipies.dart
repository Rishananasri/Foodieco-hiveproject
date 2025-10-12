import 'package:flutter/material.dart';
import 'package:pr/screens/home.dart';

class Recipie extends StatefulWidget {
  const Recipie({super.key});

  @override
  State<Recipie> createState() => _RecipieState();
}

class _RecipieState extends State<Recipie> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(
              context,
              MaterialPageRoute(builder: (context) => Home()),
            );
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
    );
  }
}
