import 'dart:io';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:pr/recipe/editrecipe.dart';
import 'package:pr/service/functions.dart';
import 'package:pr/models/recipe_model.dart';

class RecipeDetailPage extends StatefulWidget {
  RecipeDetailPage({super.key, required this.recipe, required this.recipeKey});

  RecipeModel recipe;
  final dynamic recipeKey;

  @override
  State<RecipeDetailPage> createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> {
  @override
  void initState() {
    super.initState();
    log(
      "RecipeDetailPage opened for recipe: ${widget.recipe.name}",
      name: "RecipeDetailPage",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 217, 226, 236),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 217, 226, 236),
        title: Text(
          widget.recipe.name,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        ),
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert, color: Colors.black),
            onSelected: (value) async {
              if (value == 'edit') {
                log(
                  "Edit selected for recipe: ${widget.recipe.name}",
                  name: "RecipeDetailPage",
                );

                final updatedRecipe = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => Editrecipe(
                      recipe: widget.recipe,
                      recipeKey: widget.recipeKey,
                    ),
                  ),
                );

                if (updatedRecipe != null) {
                  setState(() {
                    widget.recipe = updatedRecipe;
                  });
                  log(
                    "Recipe updated: ${widget.recipe.name}",
                    name: "RecipeDetailPage",
                  );
                }
              } else if (value == 'delete') {
                log(
                  "Delete selected for recipe: ${widget.recipe.name}",
                  name: "RecipeDetailPage",
                  level: 900,
                );

                final shouldDelete = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Delete Recipe"),
                    content: Text(
                      "Are you sure you want to delete this recipe?",
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: Text(
                          "Delete",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                );

                if (shouldDelete == true) {
                  await deleteRecipe(widget.recipeKey);
                  log(
                    "Recipe deleted: ${widget.recipe.name}",
                    name: "RecipeDetailPage",
                    level: 1000,
                  );
                  Navigator.of(context).pop();
                } else {
                  log(
                    "Delete cancelled for recipe: ${widget.recipe.name}",
                    name: "RecipeDetailPage",
                  );
                }
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(value: 'edit', child: Text('Edit')),
              PopupMenuItem(
                value: 'delete',
                child: Text('Delete', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.recipe.imagePath.isNotEmpty &&
                  File(widget.recipe.imagePath).existsSync())
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(
                    File(widget.recipe.imagePath),
                    fit: BoxFit.cover,
                    width: 200,
                    height: 200,
                  ),
                ),
              SizedBox(height: 20),
              Text(
                widget.recipe.description,
                style: TextStyle(fontSize: 16, height: 1.6),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
