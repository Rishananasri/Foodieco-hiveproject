import 'package:flutter/material.dart';
import 'package:pr/recipe/recipecategory.dart';

/// Category card widget
Widget ctrow(
  BuildContext context, {
  String? txt,
  String? label,
  required String currentUser,
}) {
  return InkWell(
    onTap: () {
      if (label != null) {
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
        color: const Color.fromARGB(60, 255, 255, 255),
        border: Border.all(
          color: const Color.fromARGB(253, 255, 255, 255),
          width: 1.5,
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
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
          const SizedBox(height: 8),
          Text(
            label ?? "Starters",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color.fromARGB(255, 107, 106, 106),
            ),
          ),
        ],
      ),
    ),
  );
}

/// Category list scrollable widget
Widget category(BuildContext context, String currentUser) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: [
        Column(
          children: [
            ctrow(context, label: "Starters", currentUser: currentUser),
            const SizedBox(height: 20),
            ctrow(
              context,
              label: "Snacks",
              txt: "assets/images/snack.jpg",
              currentUser: currentUser,
            ),
            const SizedBox(height: 20),
            ctrow(
              context,
              label: "Desserts",
              txt: "assets/images/dessert.jpg",
              currentUser: currentUser,
            ),
            const SizedBox(height: 20),
            ctrow(
              context,
              label: "Drinks",
              txt: "assets/images/drink.jpg",
              currentUser: currentUser,
            ),
            const SizedBox(height: 20),
            ctrow(
              context,
              label: "Seafood",
              txt: "assets/images/seafood.jpg",
              currentUser: currentUser,
            ),
            const SizedBox(height: 20),
            ctrow(
              context,
              label: "Breads",
              txt: "assets/images/bread.jpg",
              currentUser: currentUser,
            ),
            const SizedBox(height: 20),
            ctrow(
              context,
              label: "Pasta",
              txt: "assets/images/pasta.jpg",
              currentUser: currentUser,
            ),
          ],
        ),
        const SizedBox(width: 20),
        Column(
          children: [
            ctrow(
              context,
              label: "Rice",
              txt: "assets/images/rice.jpg",
              currentUser: currentUser,
            ),
            const SizedBox(height: 20),
            ctrow(
              context,
              label: "Curry",
              txt: "assets/images/curry.jpg",
              currentUser: currentUser,
            ),
            const SizedBox(height: 20),
            ctrow(
              context,
              label: "Salads",
              txt: "assets/images/salad.jpg",
              currentUser: currentUser,
            ),
            const SizedBox(height: 20),
            ctrow(
              context,
              label: "Soups",
              txt: "assets/images/soup.jpg",
              currentUser: currentUser,
            ),
            const SizedBox(height: 20),
            ctrow(
              context,
              label: "Fast Food",
              txt: "assets/images/fastfood.jpg",
              currentUser: currentUser,
            ),
            const SizedBox(height: 20),
            ctrow(
              context,
              label: "Grill",
              txt: "assets/images/grill.jpg",
              currentUser: currentUser,
            ),
            const SizedBox(height: 20),
            ctrow(
              context,
              label: "Sides",
              txt: "assets/images/sides.png",
              currentUser: currentUser,
            ),
          ],
        ),
      ],
    ),
  );
}
