import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarouselDemo extends StatefulWidget {
  const CarouselDemo({super.key});

  @override
  State<CarouselDemo> createState() => _CarouselDemoState();
}

class _CarouselDemoState extends State<CarouselDemo> {
  int _currentIndex = 0;
  final List<String> imgList = [
    'assets/images/carosel3.png',
    'assets/images/carosel4.png',
    'assets/images/carosel6.png',
    'assets/images/carosel7.png',
    'assets/images/carosel8.png',
    "assets/images/carosel9.png",
    "assets/images/carosel10.png",
    "assets/images/carosel11.png",
    "assets/images/carosel12.png",
    "assets/images/carosel13.png",
    "assets/images/carosel14.png",
    "assets/images/carosel15.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            color: Color.fromARGB(98, 213, 170, 255),

            padding: const EdgeInsets.symmetric(vertical: 16),
            child: CarouselSlider(
              options: CarouselOptions(
                height: 180,
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: 0.8,
                aspectRatio: 16 / 9,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
              items: imgList.map((item) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    item,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
