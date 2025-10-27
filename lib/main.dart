import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pr/models/note_model.dart';
import 'package:pr/models/recipe_model.dart';
import 'package:pr/views/screens/splash.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(NoteModelAdapter().typeId)) {
    Hive.registerAdapter(NoteModelAdapter());
  }
  if (!Hive.isAdapterRegistered(RecipeModelAdapter().typeId)) {
    Hive.registerAdapter(RecipeModelAdapter());
  }

  await Hive.openBox<NoteModel>('note_db');
  await Hive.openBox<RecipeModel>('recipe_db');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
