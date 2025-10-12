import 'package:flutter/material.dart';
import 'package:pr/widget/notes-widgets.dart';

class Notes extends StatelessWidget {
  const Notes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 217, 226, 236),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 70),
              child: Row(
                children: [
                  SizedBox(width: 30),
                  Text(
                    "Notes",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            box(),
            box(),
            box(),
            box(),
            box(),
          ],
        ),
      ),

      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 70),
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: const Color.fromARGB(255, 60, 124, 198),
          shape: CircleBorder(),
          child: Icon(Icons.add, color: Colors.white, size: 30),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
