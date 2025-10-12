import 'package:flutter/material.dart';
import 'package:pr/screens/recipies.dart';

Widget ctrow(BuildContext context, {String? txt, String? label}) {
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Recipie()),
      );
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
          SizedBox(height: 8),
          Text(
            label ?? "Starters",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: const Color.fromARGB(255, 107, 106, 106),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget category(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Column(
        children: [
          ctrow(context, label: "Starters"),
          SizedBox(height: 20),
          ctrow(context, label: "Snacks", txt: "assets/images/snack.jpg"),
          SizedBox(height: 20),
          ctrow(context, label: "Desserts", txt: "assets/images/dessert.jpg"),
          SizedBox(height: 20),
          ctrow(context, label: "Drinks", txt: "assets/images/drink.jpg"),
          SizedBox(height: 20),
          ctrow(context, label: "Seafood", txt: "assets/images/seafood.jpg"),
          SizedBox(height: 20),
          ctrow(context, label: "Breads", txt: "assets/images/bread.jpg"),
          SizedBox(height: 20),
          ctrow(context, label: "Pasta", txt: "assets/images/pasta.jpg"),
        ],
      ),
      Column(
        children: [
          ctrow(context, label: "Rice", txt: "assets/images/rice.jpg"),
          SizedBox(height: 20),
          ctrow(context, label: "Curry", txt: "assets/images/curry.jpg"),
          SizedBox(height: 20),
          ctrow(context, label: "Salads", txt: "assets/images/salad.jpg"),
          SizedBox(height: 20),
          ctrow(context, label: "Soups", txt: "assets/images/soup.jpg"),
          SizedBox(height: 20),
          ctrow(context, label: "Fast Food", txt: "assets/images/fastfood.jpg"),
          SizedBox(height: 20),
          ctrow(context, label: "Grill", txt: "assets/images/grill.jpg"),
          SizedBox(height: 20),
          ctrow(context, label: "Sides", txt: "assets/images/sides.png"),
        ],
      ),
    ],
  );
}
