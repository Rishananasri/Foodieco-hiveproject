import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pr/models/recipe_model.dart';
import 'package:pr/recipe/showrecipe.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String searchText = '';
  String currentUser = "";

  @override
  void initState() {
    super.initState();
    _loadCurrentUser();
  }

  Future<void> _loadCurrentUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      currentUser = pref.getString("currentUsername") ?? "guest";
    });
  }

  @override
  Widget build(BuildContext context) {
    final recipeBox = Hive.box<RecipeModel>('recipe_db');

    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 226, 234, 243),
                  Color.fromARGB(255, 160, 177, 199),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // Search UI
          Column(
            children: [
              const SizedBox(height: 70),
              Padding(
                padding: const EdgeInsets.all(25),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(60),
                    border: Border.all(color: Colors.white, width: 1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: TextField(
                      style: const TextStyle(color: Colors.black, fontSize: 18),
                      decoration: const InputDecoration(
                        hintText: "Search recipe...",
                        border: InputBorder.none,
                        suffixIcon: Icon(Icons.search, color: Colors.black54),
                      ),
                      onChanged: (value) {
                        setState(() {
                          searchText = value.trim().toLowerCase();
                        });
                      },
                    ),
                  ),
                ),
              ),

              // Only show results when user types something
              if (searchText.isNotEmpty)
                Expanded(
                  child: ValueListenableBuilder(
                    valueListenable: recipeBox.listenable(),
                    builder: (context, Box<RecipeModel> box, _) {
                      // Filter by current user + search text
                      final Map<dynamic, RecipeModel> allRecipes = box.toMap();
                      final results = allRecipes.entries
                          .where(
                            (entry) =>
                                entry.value.username == currentUser &&
                                entry.value.name.toLowerCase().contains(
                                  searchText,
                                ),
                          )
                          .toList();

                      if (results.isEmpty) {
                        return const Center(
                          child: Text(
                            "No recipes found",
                            style: TextStyle(fontSize: 16),
                          ),
                        );
                      }

                      return ListView.builder(
                        itemCount: results.length,
                        itemBuilder: (context, index) {
                          final recipe = results[index].value;
                          final key = results[index].key;

                          return ListTile(
                            leading: recipe.imagePath.isNotEmpty
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(6),
                                    child: Image.file(
                                      File(recipe.imagePath),
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : const Icon(Icons.image, size: 40),
                            title: Text(
                              recipe.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onTap: () {
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
                          );
                        },
                      );
                    },
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
