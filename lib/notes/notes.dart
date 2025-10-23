import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pr/service/functions.dart';
import 'package:pr/models/note_model.dart';
import 'package:pr/notes/editnote.dart';

class Notes extends StatelessWidget {
  const Notes({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: noteListNotifier,
      builder: (BuildContext ctx, List<NoteModel> noteList, Widget? child) {
        log(
          "Note list updated, total notes: ${noteList.length}",
          name: "Notes",
        );

        if (noteList.isEmpty) {
          return Center(
            child: Image.asset("assets/images/Your paragraph text (8).png"),
          );
        }

        return ListView.separated(
          padding: EdgeInsets.all(12),
          itemBuilder: (ctx, index) {
            final data = noteList[index];
            final key = Hive.box<NoteModel>('note_db').keyAt(index);

            return Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(86, 255, 255, 255),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          data.title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      PopupMenuButton<String>(
                        onSelected: (value) {
                          if (value == 'edit') {
                            log(
                              "Edit selected for note key=$key",
                              name: "Notes",
                            );
                            showDialog(
                              context: context,
                              builder: (_) =>
                                  AddEditNoteDialog(noteKey: key, note: data),
                            );
                          } else if (value == 'delete') {
                            log(
                              "Delete selected for note key=$key",
                              name: "Notes",
                            );
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: Text("Delete Note"),
                                content: Text(
                                  "Are you sure you want to delete this note?",
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      log(
                                        "Delete cancelled for note key=$key",
                                        name: "Notes",
                                      );
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("Cancel"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      deletenote(key);
                                      log(
                                        "Note deleted: key=$key",
                                        name: "Notes",
                                      );
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("OK"),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                        itemBuilder: (context) => [
                          PopupMenuItem(value: 'edit', child: Text("Edit")),
                          PopupMenuItem(
                            value: 'delete',
                            child: Text(
                              "Delete",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                        icon: Icon(Icons.more_vert),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    data.content,
                    style: TextStyle(fontSize: 15, color: Colors.black87),
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (ctx, index) => SizedBox(height: 12),
          itemCount: noteList.length,
        );
      },
    );
  }
}
