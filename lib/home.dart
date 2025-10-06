import 'package:flutter/material.dart';
import 'package:pr/widget/carousel-slider.dart';
import 'package:pr/widget/home-widgets.dart';

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
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: 20),
              Container(
                color: Color.fromARGB(196, 221, 192, 251),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Image.asset(
                        "assets/images/logoname-removebg-preview.png",
                        height: 50,
                        width: 150,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 40),
                      SizedBox(height: 220, child: CarouselDemo()),
                      SizedBox(height: 50),
                      category(context),
                      SizedBox(height: 70),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
