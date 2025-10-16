import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pr/models/note_model.dart';
import 'package:pr/models/recipe_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

ValueNotifier<List<RecipeModel>> recipeListNotifier = ValueNotifier([]);
ValueNotifier<List<NoteModel>> noteListNotifier = ValueNotifier([]);

Future<String?> getCurrentUserId() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('currentUsername');
}

// ------------------ Notes Functions ------------------

Future<void> addNote(NoteModel value) async {
  final userId = await getCurrentUserId();
  if (userId == null) return;

  final noteDB = Hive.box<NoteModel>('note_db');
  final userNote = NoteModel(
    title: value.title,
    content: value.content,
    userId: userId,
  );
  await noteDB.add(userNote);
  getAllnotes();
}

Future<void> getAllnotes() async {
  final userId = await getCurrentUserId();
  if (userId == null) return;

  final noteDB = Hive.box<NoteModel>('note_db');
  final allNotes = noteDB.values.toList();
  final userNotes = allNotes.where((note) => note.userId == userId).toList();

  noteListNotifier.value = userNotes;
  noteListNotifier.notifyListeners();
}

Future<void> deletenote(int key) async {
  final noteDB = Hive.box<NoteModel>('note_db');
  await noteDB.delete(key);
  getAllnotes();
}

Future<void> editNote(int key, NoteModel updatedNote) async {
  final userId = await getCurrentUserId();
  if (userId == null) return;

  final noteDB = Hive.box<NoteModel>('note_db');
  final updatedWithUser = NoteModel(
    title: updatedNote.title,
    content: updatedNote.content,
    userId: userId,
  );
  await noteDB.put(key, updatedWithUser);
  getAllnotes();
}
// ---------------- Recipe functions ----------------

Future<void> addRecipe(RecipeModel recipe) async {
  final recipeBox = Hive.box<RecipeModel>('recipe_db');
  await recipeBox.add(recipe);
  getAllRecipes();
}

Future<void> getAllRecipes() async {
  final recipeBox = Hive.box<RecipeModel>('recipe_db');
  recipeListNotifier.value = recipeBox.values.toList();
  recipeListNotifier.notifyListeners();
}

Future<void> deleteRecipe(dynamic key) async {
  final recipeBox = Hive.box<RecipeModel>('recipe_db');
  await recipeBox.delete(key);
  getAllRecipes();
}

