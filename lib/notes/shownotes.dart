import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:pr/service/functions.dart';
import 'package:pr/notes/addnote.dart';
import 'package:pr/notes/notes.dart';

class Note extends StatefulWidget {
  const Note({super.key});

  @override
  State<Note> createState() => _NoteState();
}

class _NoteState extends State<Note> {
  double fabX = 335; 
  double fabY = 670; 

  @override
  void initState() {
    super.initState();
    log("Note screen initialized", name: "NoteScreen");
    getAllnotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 217, 226, 236),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 217, 226, 236),
        automaticallyImplyLeading: false,
        title: Padding(
          padding: EdgeInsets.only(left: 15),
          child: Text("Notes", style: TextStyle(fontWeight: FontWeight.w500)),
        ),
      ),

      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 10),
                SizedBox(height: 740, child: Notes()),
              ],
            ),
          ),

          Positioned(
            left: fabX, 
            top: fabY, 
            child: GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  fabX += details.delta.dx;
                  fabY += details.delta.dy;
                });
              },
              child: FloatingActionButton(
                onPressed: () {
                  log(
                    "FloatingActionButton pressed: navigating to AddNoteScreen",
                    name: "NoteScreen",
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddNoteScreen()),
                  );
                },
                backgroundColor: const Color.fromARGB(255, 60, 124, 198),
                shape: CircleBorder(),
                child: Icon(Icons.add, color: Colors.white, size: 30),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
