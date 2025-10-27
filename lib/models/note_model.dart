import 'package:hive/hive.dart';
part 'adapters/note_model.g.dart';

@HiveType(typeId: 1)
class NoteModel {
  @HiveField(0)
  int? id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String content;

  @HiveField(3)
  final String userId; 

  NoteModel({
    required this.title,
    required this.content,
    required this.userId,
    this.id,
  });
}
