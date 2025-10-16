import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pr/models/functions.dart';
import 'package:pr/models/note_model.dart';
import 'package:pr/notes/editnote.dart';

class Notes extends StatelessWidget {
  const Notes({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: noteListNotifier,
      builder: (BuildContext ctx, List<NoteModel> noteList, Widget? child) {
        if (noteList.isEmpty) {
          return const Center(
            child: Text(
              "No notes added yet",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(12),
          itemBuilder: (ctx, index) {
            final data = noteList[index];
            final key = Hive.box<NoteModel>('note_db').keyAt(index);

            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          data.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (_) =>
                                    AddEditNoteDialog(noteKey: key, note: data),
                              );
                            },
                            icon: const Icon(Icons.edit),
                            color: Colors.black54,
                          ),
                          IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: const Text("Delete Note"),
                                  content: const Text(
                                    "Are you sure you want to delete this note?",
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(
                                          context,
                                        ).pop(); // just close dialog
                                      },
                                      child: const Text("Cancel"),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        deletenote(
                                          key,
                                        ); // delete only after confirmation
                                        Navigator.of(
                                          context,
                                        ).pop(); // close the dialog

                                      },
                                      child: const Text("OK"),
                                    ),
                                  ],
                                ),
                              );
                            },
                            icon: const Icon(Icons.delete_outline_rounded),
                            color: Colors.redAccent,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    data.content,
                    style: const TextStyle(fontSize: 15, color: Colors.black87),
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (ctx, index) => const SizedBox(height: 12),
          itemCount: noteList.length,
        );
      },
    );
  }
}
