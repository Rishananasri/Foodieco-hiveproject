import 'package:flutter/material.dart';

Widget ctrow({String? txt, String? label}) {
  return Container(
    height: 155,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: const Color.fromARGB(60, 255, 255, 255),
      border: Border.all(
        color: const Color.fromARGB(190, 255, 255, 255),
        width: 1,
      ),
      // boxShadow: [
      //   BoxShadow(
      //     offset: Offset(5, 5),
      //     blurRadius: 10,
      //     color: const Color.fromARGB(28, 0, 0, 0),
      //   ),
      // ],
    ),
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 100,
            width: 170,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  offset: Offset(5, 5),
                  color: const Color.fromARGB(44, 0, 0, 0),
                  blurRadius: 5,
                ),
              ],
              color: const Color.fromARGB(154, 255, 255, 255),
              borderRadius: BorderRadius.circular(20),
            ),
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
            color: const Color.fromARGB(255, 255, 255, 255),
            shadows: [
              BoxShadow(
                offset: Offset(2, 2),
                blurRadius: 15,
                color: const Color.fromARGB(255, 72, 20, 96),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget category() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Column(
        children: [
          ctrow(label: "Starters"),
          SizedBox(height: 20),
          ctrow(label: "Snacks", txt: "assets/images/snack.jpg"),
          SizedBox(height: 20),
          ctrow(label: "Desserts", txt: "assets/images/dessert.jpg"),
          SizedBox(height: 20),
          ctrow(label: "Drinks", txt: "assets/images/drink.jpg"),
          SizedBox(height: 20),
          ctrow(label: "Seafood", txt: "assets/images/seafood.jpg"),
          SizedBox(height: 20),
          ctrow(label: "Breads", txt: "assets/images/bread.jpg"),
          SizedBox(height: 20),
          ctrow(label: "Pasta", txt: "assets/images/pasta.jpg"),
        ],
      ),
      Column(
        children: [
          ctrow(label: "Rice", txt: "assets/images/rice.jpg"),
          SizedBox(height: 20),
          ctrow(label: "Curry", txt: "assets/images/curry.jpg"),
          SizedBox(height: 20),
          ctrow(label: "Salads", txt: "assets/images/salad.jpg"),
          SizedBox(height: 20),
          ctrow(label: "Soups", txt: "assets/images/soup.jpg"),
          SizedBox(height: 20),
          ctrow(label: "Fast Food", txt: "assets/images/fastfood.jpg"),
          SizedBox(height: 20),
          ctrow(label: "Grill", txt: "assets/images/grill.jpg"),
          SizedBox(height: 20),
          ctrow(label: "Sides", txt: "assets/images/sides.png"),
        ],
      ),
    ],
  );
}
