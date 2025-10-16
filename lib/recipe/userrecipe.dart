// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import 'package:pr/models/recipe_model.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class UserRecipesPage extends StatefulWidget {
//   const UserRecipesPage({super.key});

//   @override
//   State<UserRecipesPage> createState() => _UserRecipesPageState();
// }

// class _UserRecipesPageState extends State<UserRecipesPage> {
//   List<RecipeModel> userRecipes = [];
//   String currentUser = 'guest';

//   @override
//   void initState() {
//     super.initState();
//     _loadUserRecipes();
//   }

//   Future<void> _loadUserRecipes() async {
//     // Get current logged-in username
//     final prefs = await SharedPreferences.getInstance();
//     currentUser = prefs.getString('currentUser') ?? 'guest';

//     // Load all recipes
//     final box = Hive.box<RecipeModel>('recipe_db');
//     final allRecipes = box.values.toList();

//     // Filter recipes for the current user
//     final filtered = allRecipes.where((r) => r.username == currentUser).toList();

//     setState(() {
//       userRecipes = filtered;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("$currentUser's Recipes"),
//       ),
//       body: userRecipes.isEmpty
//           ? const Center(
//               child: Text(
//                 "No recipes found. Start adding some!",
//                 style: TextStyle(fontSize: 18),
//               ),
//             )
//           : ListView.builder(
//               padding: const EdgeInsets.all(12),
//               itemCount: userRecipes.length,
//               itemBuilder: (context, index) {
//                 final recipe = userRecipes[index];
//                 return Card(
//                   margin: const EdgeInsets.symmetric(vertical: 8),
//                   child: ListTile(
//                     leading: recipe.imagePath != null
//                         ? Image.file(
//                             File(recipe.imagePath),
//                             width: 60,
//                             height: 60,
//                             fit: BoxFit.cover,
//                           )
//                         : const SizedBox(width: 60, height: 60),
//                     title: Text(recipe.name),
//                     subtitle: Text(recipe.category),
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }
