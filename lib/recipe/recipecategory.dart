import 'dart:io';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pr/models/recipe_model.dart';
import 'package:pr/recipe/editrecipe.dart';
import 'package:pr/recipe/showrecipe.dart';

class Recipie extends StatefulWidget {
  final String selectedCategory;
  final String currentUser;
  const Recipie({
    super.key,
    required this.selectedCategory,
    required this.currentUser,
  });

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
        title: Text(
          widget.selectedCategory,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: recipeBox.listenable(),
        builder: (context, Box<RecipeModel> box, _) {
          final Map<dynamic, RecipeModel> allRecipes = box.toMap();
          final filtered = allRecipes.entries
              .where(
                (e) =>
                    e.value.category == widget.selectedCategory &&
                    e.value.username == widget.currentUser,
              )
              .toList();

          log(
            "${filtered.length} recipes found for category ${widget.selectedCategory}",
            name: "Recipie",
          );

          if (filtered.isEmpty) {
            log("No recipes found", name: "Recipie", level: 800);
            return  Center(
              child: Text("No recipes found in this category"),
            );
          }

          return Padding(
            padding: EdgeInsets.all(15),
            child: GridView.builder(
              itemCount: filtered.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                childAspectRatio: 0.9,
              ),
              itemBuilder: (context, index) {
                final key = filtered[index].key;
                final recipe = filtered[index].value;

                return Stack(
                  children: [
                    InkWell(
                      onTap: () {
                        log("Recipe tapped: ${recipe.name}", name: "Recipie");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RecipeDetailPage(
                              recipe: recipe,
                              recipeKey: key,
                            ),
                          ),
                        );
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12),
                                ),
                                child: recipe.imagePath.isNotEmpty
                                    ? Image.file(
                                        File(recipe.imagePath),
                                        fit: BoxFit.cover,
                                      )
                                    : Icon(Icons.image, size: 60),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                recipe.name,
                                textAlign: TextAlign.center,
                                style:  TextStyle(
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Positioned(
                      right: 0,
                      child: PopupMenuButton<String>(
                        icon:  Icon(Icons.more_vert),
                        onSelected: (value) async {
                          if (value == 'edit') {
                            log(
                              "Edit selected for recipe: ${recipe.name}",
                              name: "Recipie",
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    Editrecipe(recipe: recipe, recipeKey: key),
                              ),
                            );
                          } else if (value == 'delete') {
                            log(
                              "Delete selected for recipe: ${recipe.name}",
                              name: "Recipie",
                              level: 900,
                            );
                            final shouldDelete = await showDialog<bool>(
                              context: context,
                              builder: (_) => AlertDialog(
                                title:  Text("Delete Recipe"),
                                content:  Text(
                                  "Are you sure you want to delete this?",
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, false),
                                    child: Text("Cancel"),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, true),
                                    child: Text(
                                      "Delete",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                ],
                              ),
                            );

                            if (shouldDelete == true) {
                              await recipeBox.delete(key);
                              log(
                                "Recipe deleted: ${recipe.name}",
                                name: "Recipie",
                              );
                            } else {
                              log(
                                "Delete cancelled for recipe: ${recipe.name}",
                                name: "Recipie",
                              );
                            }
                          }
                        },
                        itemBuilder: (context) =>  [
                          PopupMenuItem(value: 'edit', child: Text('Edit')),
                          PopupMenuItem(value: 'delete', child: Text('Delete')),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
