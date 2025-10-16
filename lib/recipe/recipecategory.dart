import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pr/models/recipe_model.dart';
import 'package:pr/recipe/showrecipe.dart';

class Recipie extends StatefulWidget {
  final String selectedCategory;
  final String currentUser;
  const Recipie({super.key, required this.selectedCategory, required this.currentUser});

  @override
  State<Recipie> createState() => _RecipieState();
}

class _RecipieState extends State<Recipie> {
  late Box<RecipeModel> recipeBox;

  @override
  void initState() {
    super.initState();
    recipeBox = Hive.box<RecipeModel>('recipe_db');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 217, 226, 236),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 217, 226, 236),
        title: Text(widget.selectedCategory, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w400)),
      ),
      body: ValueListenableBuilder(
        valueListenable: recipeBox.listenable(),
        builder: (context, Box<RecipeModel> box, _) {
          final Map<dynamic, RecipeModel> allRecipes = box.toMap();
          final filtered = allRecipes.entries
              .where((e) => e.value.category == widget.selectedCategory && e.value.username == widget.currentUser)
              .toList();

          if (filtered.isEmpty) {
            return const Center(child: Text("No recipes found in this category"));
          }

          return Padding(
            padding: const EdgeInsets.all(15),
            child: GridView.builder(
              itemCount: filtered.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 15, childAspectRatio: 0.9,
              ),
              itemBuilder: (context, index) {
                final key = filtered[index].key;
                final recipe = filtered[index].value;
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RecipeDetailPage(recipe: recipe, recipeKey: key)),
                    );
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: recipe.imagePath.isNotEmpty
                              ? ClipRRect(
                                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
                                  child: Image.file(File(recipe.imagePath), fit: BoxFit.fill),
                                )
                              : const Icon(Icons.image, size: 60),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(recipe.name, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w400)),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
