import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:pr/models/note_model.dart';
import 'package:pr/service/functions.dart';
import 'package:pr/widget/bottomnavbar.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    log("AddNoteScreen Initialized", name: "AddNote");
  }

  @override
  void dispose() {
    log("AddNoteScreen Disposed", name: "AddNote");
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _onSaveNote(BuildContext context) {
    final title = _titleController.text.trim();
    final content = _contentController.text.trim();
    log(
      "Attempting to save note: Title='$title', Content length=${content.length}",
      name: "AddNote",
    );

    if (title.isEmpty || content.isEmpty) {
      log("Validation failed: Missing title or content", name: "AddNote");
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text("Incomplete"),
          content: Text("Please fill all fields."),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("OK"),
            ),
          ],
        ),
      );
      return;
    }
    final note = NoteModel(title: title, content: content, userId: "");
    addNote(note);
    log("Note saved successfully: $note", name: "AddNote");

    _titleController.clear();
    _contentController.clear();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Saved"),
        content: Text("The note has been saved successfully."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => Bottomnavbar(initialIndex: 3),
                ),
              );
            },
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 217, 226, 236),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 217, 226, 236),
        actions: [
          IconButton(
            onPressed: () => _onSaveNote(context),
            icon: Padding(
              padding: EdgeInsets.only(right: 15),
              child: Icon(Icons.check, size: 30),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.all(20),
            child: Container(
              height: 60,
              width: 370,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Title",
                ),
              ),
            ),
          ),
          SizedBox(height: 30),
          Container(
            height: 500,
            width: 370,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              controller: _contentController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Start writing your notes....",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
