import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:pr/widget/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pr/screens/add.dart';
import 'package:pr/screens/chart.dart';
import 'package:pr/screens/home.dart';
import 'package:pr/screens/notes.dart';
import 'package:pr/screens/search.dart';

class Bottomnavbar extends StatefulWidget {
  final bool justLoggedIn; // Add this property

  const Bottomnavbar({
    super.key,
    this.justLoggedIn = false,
  }); 
  @override
  State<Bottomnavbar> createState() => _BottomnavbarState();
}

class _BottomnavbarState extends State<Bottomnavbar> {
  int _currentIndex = 0;

  List<Widget> body = [Home(), Search(), Add(), Chart(), Notes()];

  final Color navBarColor = Color.fromARGB(255, 192, 208, 226);
  final Color selectedButtonColor = Color.fromARGB(255, 40, 84, 135);

  @override
  void initState() {
    super.initState();
    if (widget.justLoggedIn) {
      showWelcome();
    }
  }

  void showWelcome() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String username = pref.getString("username") ?? "User";

    await showWelcomeDialog(context, username);
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
            Icons.pie_chart_rounded,
            size: 30,
            color: _currentIndex == 3 ? Colors.white : Colors.black,
          ),
          Icon(
            Icons.edit_note,
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
