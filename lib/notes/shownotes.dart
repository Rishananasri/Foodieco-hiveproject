import 'package:flutter/material.dart';
import 'package:pr/models/functions.dart';
import 'package:pr/notes/addnote.dart';
import 'package:pr/notes/notes.dart';

class Note extends StatefulWidget {
  const Note({super.key});

  @override
  State<Note> createState() => _NoteState();
}

class _NoteState extends State<Note> {
  @override
  void initState() {
    super.initState();
    getAllnotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 217, 226, 236),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 217, 226, 236),
        automaticallyImplyLeading: false,
        title: const Padding(
          padding: EdgeInsets.only(left: 15),
          child: Text("Notes", style: TextStyle(fontWeight: FontWeight.w500)),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            SizedBox(height: 10),
            SizedBox(height: 740, child: Notes()),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 70),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddNoteScreen()),
            );
          },
          backgroundColor: const Color.fromARGB(255, 60, 124, 198),
          shape: const CircleBorder(),
          child: const Icon(Icons.add, color: Colors.white, size: 30),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
