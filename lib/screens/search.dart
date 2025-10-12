import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 940,
            width: 430,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 226, 234, 243),
                  Color.fromARGB(255, 205, 218, 232),
                  Color.fromARGB(255, 199, 210, 221),
                  Color.fromARGB(255, 178, 194, 213),
                  Color.fromARGB(255, 195, 204, 216),
                  Color.fromARGB(255, 184, 197, 214),
                  Color.fromARGB(255, 160, 177, 199),
                  Color.fromARGB(255, 227, 234, 242),
                ],
                begin: AlignmentGeometry.topLeft,
                end: AlignmentGeometry.bottomRight,
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(height: 70),
              Padding(
                padding: const EdgeInsets.all(25),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(80, 255, 255, 255),
                    borderRadius: BorderRadius.circular(60),
                    border: Border.all(color: Colors.white, width: 1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: TextField(
                      style: TextStyle(color: Colors.white, fontSize: 18),
                      decoration: InputDecoration(
                        hintText: "Search...",
                        border: InputBorder.none,
                        suffixIcon: Icon(Icons.search),
                      ),
                    ),
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
