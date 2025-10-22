import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:pr/service/functions.dart';
import 'package:pr/models/note_model.dart';

class AddEditNoteDialog extends StatefulWidget {
  final int? noteKey;
  final NoteModel? note;

  const AddEditNoteDialog({this.noteKey, this.note, super.key});

  @override
  State<AddEditNoteDialog> createState() => _AddEditNoteDialogState();
}

class _AddEditNoteDialogState extends State<AddEditNoteDialog> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _contentController.text = widget.note!.content;
      log(
        "Editing existing note: key=${widget.noteKey}, title=${widget.note!.title}",
        name: "AddEditNoteDialog",
      );
    } else {
      log("Adding new note", name: "AddEditNoteDialog");
    }
  }

  @override
  void dispose() {
    log("AddEditNoteDialog disposed", name: "AddEditNoteDialog");
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _saveNote() {
    final title = _titleController.text.trim();
    final content = _contentController.text.trim();
    log(
      "Save button pressed: title='$title', content length=${content.length}",
      name: "AddEditNoteDialog",
    );

    if (title.isEmpty || content.isEmpty) {
      log(
        "Validation failed: Title or content empty",
        name: "AddEditNoteDialog",
      );
      return;
    }

    final note = NoteModel(title: title, content: content, userId: "");

    if (widget.note == null) {
      addNote(note);
      log("Note added: $note", name: "AddEditNoteDialog");
    } else {
      editNote(widget.noteKey!, note);
      log(
        "Note edited: key=${widget.noteKey}, $note",
        name: "AddEditNoteDialog",
      );
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:  Text("Edit Note"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleController,
            decoration:  InputDecoration(hintText: "Title"),
          ),
          TextField(
            controller: _contentController,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration:  InputDecoration(hintText: "Content"),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            log("Cancel pressed", name: "AddEditNoteDialog");
            Navigator.pop(context);
          },
          child: const Text("Cancel"),
        ),
        ElevatedButton(onPressed: _saveNote, child:  Text("Save")),
      ],
    );
  }
}
