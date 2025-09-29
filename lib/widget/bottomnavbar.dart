import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:pr/add.dart';
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
  final List<Widget> body = const [Home(), Search(), Add(), Notes()];

  final List<Color> buttonColors = [
    Color.fromARGB(196, 161, 72, 249),
    Color.fromARGB(215, 246, 84, 173),
    Color.fromARGB(217, 54, 218, 128),
    Color.fromARGB(187, 223, 208, 39),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: body[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        index: _currentIndex,
        height: 60,
        backgroundColor: const Color.fromARGB(0, 189, 44, 44),
        color: Colors.white,
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
