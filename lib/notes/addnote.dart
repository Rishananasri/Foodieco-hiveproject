import 'package:flutter/material.dart';
import 'package:pr/models/note_model.dart';
import 'package:pr/models/functions.dart';
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
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _onSaveNote(BuildContext context) {
    final title = _titleController.text.trim();
    final content = _contentController.text.trim();

    if (title.isEmpty || content.isEmpty) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Incomplete"),
          content: const Text("Please fill all fields."),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("OK"),
            ),
          ],
        ),
      );
      return;
    }

    // ✅ Create note (userId will be added inside addNote)
    final note = NoteModel(title: title, content: content, userId: "");
    addNote(note);

    _titleController.clear();
    _contentController.clear();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Saved"),
        content: const Text("The note has been saved successfully."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => Bottomnavbar(initialIndex: 4),
                ),
              );
            },
            child: const Text("OK"),
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
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              height: 60,
              width: 370,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Title",
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          Container(
            height: 500,
            width: 370,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              controller: _contentController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: const InputDecoration(
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
