import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:pr/notes/shownotes.dart';
import 'package:pr/recipe/addrecipe.dart';
import 'package:pr/views/screens/search.dart';
import 'package:pr/views/widget/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:pr/screens/chart.dart';
import 'package:pr/views/screens/home.dart';

class Bottomnavbar extends StatefulWidget {
  final bool justLoggedIn;
  final int initialIndex;
  const Bottomnavbar({
    super.key,
    this.justLoggedIn = false,
    this.initialIndex = 0,
  });

  @override
  State<Bottomnavbar> createState() => _BottomnavbarState();
}

class _BottomnavbarState extends State<Bottomnavbar> {
  late int _currentIndex;

  List<Widget> body = [Home(), Search(), Add(), Note()];

  final Color navBarColor = const Color.fromARGB(255, 192, 208, 226);
  final Color selectedButtonColor = const Color.fromARGB(255, 40, 84, 135);

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    log(
      "Bottomnavbar initialized with index: $_currentIndex",
      name: "Bottomnavbar",
    );

    if (widget.justLoggedIn) {
      log("User just logged in, showing welcome dialog", name: "Bottomnavbar");
      showWelcome();
    }
  }

  void showWelcome() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String username = pref.getString("currentUsername") ?? "User";

      await showWelcomeDialog(context, username);
    } catch (e) {
      log(
        "Error showing welcome dialog: $e",
        name: "Bottomnavbar",
        level: 1000,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: body[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        index: _currentIndex,
        height: 60,
        backgroundColor: Colors.transparent,
        color: navBarColor,
        buttonBackgroundColor: selectedButtonColor,
        animationDuration: Duration(milliseconds: 300),
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
          // Icon(
          //   Icons.pie_chart_rounded,
          //   size: 30,
          //   color: _currentIndex == 3 ? Colors.white : Colors.black,
          // ),
          Icon(
            Icons.edit_note,
            size: 30,
            color: _currentIndex == 3 ? Colors.white : Colors.black,
          ),
        ],
        onTap: (index) {
          log("Bottom navbar tapped, new index: $index", name: "Bottomnavbar");
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
