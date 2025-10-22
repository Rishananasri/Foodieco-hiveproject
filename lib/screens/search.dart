import 'dart:io';
import 'dart:developer'; 
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
  String currentUser = '';

  @override
  void initState() {
    super.initState();
    log("Search Page Initialized", name: "SearchPage");
    _loadCurrentUser();
  }

  @override
  void dispose() {
    log("Search Page Disposed", name: "SearchPage");
    super.dispose();
  }

  Future<void> _loadCurrentUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      currentUser = pref.getString("currentUsername") ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    final recipeBox = Hive.box<RecipeModel>('recipe_db');

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 217, 226, 236),
      body: Column(
        children: [
           SizedBox(height: 70),
          Padding(
            padding:  EdgeInsets.all(25),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.4),
                borderRadius: BorderRadius.circular(60),
                border: Border.all(color: Colors.white, width: 1),
              ),
              child: Padding(
                padding:  EdgeInsets.only(left: 30),
                child: TextField(
                  style:  TextStyle(color: Colors.black, fontSize: 18),
                  decoration:  InputDecoration(
                    hintText: "Search recipe...",
                    border: InputBorder.none,
                    suffixIcon: Icon(Icons.search, color: Colors.black54),
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchText = value.trim().toLowerCase();
                    });
                    log("Search text changed: $searchText", name: "SearchPage");
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: recipeBox.listenable(),
              builder: (context, Box<RecipeModel> box, _) {
                final Map<dynamic, RecipeModel> allRecipes = box.toMap();

                final results = allRecipes.entries
                    .where(
                      (entry) =>
                          entry.value.username == currentUser &&
                          (searchText.isEmpty
                              ? true
                              : entry.value.name.toLowerCase().startsWith(
                                  searchText,
                                )),
                    )
                    .toList();

                log(
                  "Found ${results.length} search results for user $currentUser with searchText '$searchText'",
                  name: "SearchPage",
                );

                if (results.isEmpty) {
                  return Center(
                    child: Image.asset(
                      "assets/images/Your paragraph text (5).png",
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
                          :  Icon(Icons.image, size: 40),
                      title: Text(
                        recipe.name,
                        style:  TextStyle(fontWeight: FontWeight.w500),
                      ),
                      onTap: () {
                        log(
                          "Tapped recipe: ${recipe.name} (key: $key) by $currentUser",
                          name: "SearchPage",
                        );
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
    );
  }
}
