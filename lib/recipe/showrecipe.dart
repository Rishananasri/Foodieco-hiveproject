import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pr/models/functions.dart';
import 'package:pr/models/recipe_model.dart';

class RecipeDetailPage extends StatelessWidget {
  final RecipeModel recipe;
  final dynamic recipeKey;

  const RecipeDetailPage({
    super.key,
    required this.recipe,
    required this.recipeKey,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 217, 226, 236),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 217, 226, 236),
        title: Text(
          recipe.name,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline_rounded, color: Colors.red),
            onPressed: () async {
              await deleteRecipe(recipeKey);

              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Delete Recipe"),
                    content: const Text(
                      "Are you sure you want to delete this recipe ?",
                    ),
                    actions: [
                      TextButton(
                        child: const Text("OK"),
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (recipe.imagePath.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(
                    File(recipe.imagePath),
                    fit: BoxFit.cover,
                    height: 200,
                    width: 200,
                  ),
                ),
              SizedBox(height: 20),
              // Text(
              //   recipe.name,
              //   style: const TextStyle(
              //     fontSize: 24,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              SizedBox(height: 20),
              Text(
                recipe.description,
                style: TextStyle(fontSize: 16, height: 1.6),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
