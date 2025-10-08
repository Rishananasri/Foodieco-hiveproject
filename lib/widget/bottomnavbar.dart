import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:pr/add.dart';
import 'package:pr/chart.dart';
import 'package:pr/home.dart';
import 'package:pr/notes.dart';
import 'package:pr/search.dart';

class Bottomnavbar extends StatefulWidget {
  const Bottomnavbar({super.key});

  @override
  State<Bottomnavbar> createState() => _BottomnavbarState();
}

class _BottomnavbarState extends State<Bottomnavbar> {
  int _currentIndex = 0;
   List<Widget> body = [Home(), Search(), Add(), Notes(), Chart()];

  final List<Color> buttonColors = [
    Color.fromARGB(251, 160, 72, 249),
    Color.fromARGB(255, 246, 84, 173),
    Color.fromARGB(255, 60, 216, 68),
    Color.fromARGB(255, 214, 198, 21),
    const Color.fromARGB(255, 48, 160, 240),
  ];

  final List<Color> navBarColors = [
    Color.fromARGB(255, 233, 225, 251),
    Color.fromARGB(255, 252, 218, 236),
    Color.fromARGB(255, 218, 249, 218),
    Color.fromARGB(255, 247, 242, 220),
    Color.fromARGB(255, 219, 234, 248),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: body[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        index: _currentIndex,
        height: 60,
        backgroundColor: Colors.transparent,
        color: navBarColors[_currentIndex],
        buttonBackgroundColor: buttonColors[_currentIndex],
        animationDuration: const Duration(milliseconds: 300),
        items: [
          Icon(
            Icons.home,
            size: 30,
            color: _currentIndex == 0 ? Colors.white : Colors.black,
          ),
          Icon(
            Icons.search,
            size: 30,
            color: _currentIndex == 1 ? Colors.white : Colors.black,
          ),
          Icon(
            Icons.add,
            size: 30,
            color: _currentIndex == 2 ? Colors.white : Colors.black,
          ),
          Icon(
            Icons.edit_note,
            size: 30,
            color: _currentIndex == 3 ? Colors.white : Colors.black,
          ),
          Icon(
            Icons.pie_chart_rounded,
            size: 30,
            color: _currentIndex == 4 ? Colors.white : Colors.black,
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
