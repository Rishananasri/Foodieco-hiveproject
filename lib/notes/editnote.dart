import 'package:flutter/material.dart';
import 'package:pr/models/functions.dart';
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Edit Note"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(hintText: "Title"),
          ),
          TextField(
            controller: _contentController,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: const InputDecoration(hintText: "Content"),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            final title = _titleController.text.trim();
            final content = _contentController.text.trim();
            if (title.isEmpty || content.isEmpty) return;

            final note = NoteModel(title: title, content: content, userId: "");

            if (widget.note == null) {
              addNote(note);
            } else {
              editNote(widget.noteKey!, note);
            }

            Navigator.pop(context);
          },
          child: const Text("Save"),
        ),
      ],
    );
  }
}
