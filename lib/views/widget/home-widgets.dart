import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pr/models/recipe_model.dart';
import 'package:pr/recipe/recipecategory.dart';

Widget ctrow(
  BuildContext context, {
  String? txt,
  String? label,
  required String currentUser,
}) {
  return InkWell(
    onTap: () {
      if (label != null) {
        log(
          "Category tapped: $label by user: $currentUser",
          name: "HomeWidgets",
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                Recipie(selectedCategory: label, currentUser: currentUser),
          ),
        );
      }
    },
    child: Container(
      height: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            offset: Offset(5, 5),
            color: const Color.fromARGB(43, 0, 0, 0),
            blurRadius: 10,
          ),
        ],
        color: const Color.fromARGB(103, 138, 163, 203),
        border: Border.all(
          color: const Color.fromARGB(252, 232, 239, 246),
          width: 1.5,
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: SizedBox(
              height: 100,
              width: 170,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  txt ?? "assets/images/staters.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            label ?? "Starters",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget category(BuildContext context, String currentUser) {
  final recipeBox = Hive.box<RecipeModel>('recipe_db');

  final categories = [
    {"label": "Starters", "image": "assets/images/staters.png"},
    {"label": "Snacks", "image": "assets/images/snack.jpg"},
    {"label": "Desserts", "image": "assets/images/dessert.jpg"},
    {"label": "Drinks", "image": "assets/images/drink.jpg"},
    {"label": "Seafood", "image": "assets/images/seafood.jpg"},
    {"label": "Breads", "image": "assets/images/bread.jpg"},
    {"label": "Pasta", "image": "assets/images/pasta.jpg"},
    {"label": "Rice", "image": "assets/images/rice.jpg"},
    {"label": "Curry", "image": "assets/images/curry.jpg"},
    {"label": "Salads", "image": "assets/images/salad.jpg"},
    {"label": "Soups", "image": "assets/images/soup.jpg"},
    {"label": "Fast Food", "image": "assets/images/fastfood.jpg"},
    {"label": "Grill", "image": "assets/images/grill.jpg"},
    {"label": "Sides", "image": "assets/images/sides.png"},
  ];

  return ValueListenableBuilder(
    valueListenable: recipeBox.listenable(),
    builder: (context, Box<RecipeModel> box, _) {
      final filteredCategories = categories.where((cat) {
        final catRecipes = box.values.where(
          (recipe) =>
              recipe.username == currentUser && recipe.category == cat["label"],
        );
        return catRecipes.isNotEmpty;
      }).toList();

      if (filteredCategories.isEmpty) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Center(
            child: Image(
              image: AssetImage("assets/images/Your paragraph text (3).png"),
            ),
          ),
        );
      }

      log(
        "Displaying ${filteredCategories.length} categories for user: $currentUser",
        name: "HomeWidgets",
      );

      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Column(
              children: filteredCategories
                  .sublist(0, (filteredCategories.length / 2).ceil())
                  .map(
                    (cat) => Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: ctrow(
                        context,
                        label: cat["label"],
                        txt: cat["image"],
                        currentUser: currentUser,
                      ),
                    ),
                  )
                  .toList(),
            ),
            SizedBox(width: 20),
            Column(
              children: filteredCategories
                  .sublist((filteredCategories.length / 2).ceil())
                  .map(
                    (cat) => Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: ctrow(
                        context,
                        label: cat["label"],
                        txt: cat["image"],
                        currentUser: currentUser,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      );
    },
  );
}
