import 'package:flutter/material.dart';

class Add extends StatefulWidget {
  const Add({super.key});

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  String? selectedValue;

  final List<String> items = [
    "Starters",
    "Snacks",
    "Curry",
    "Rice",
    "Breads",
    "Salads",
    "Soups",
    "Desserts",
    "Drinks",
    "Grill",
    "Pasta",
    "Fast Food",
    "Seafood",
    "Sides",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(217, 184, 242, 210),
      body: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.only(left: 300),
              child: ElevatedButton(
                onPressed: () {},
                child: const Text("Save"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(7, 7),
                      blurRadius: 10,
                      color: const Color.fromARGB(154, 0, 0, 0),
                    ),
                  ],
                ),
              ),
            ),

            Container(
              height: 60,
              width: 350,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(7, 7),
                    blurRadius: 10,
                    color: const Color.fromARGB(154, 0, 0, 0),
                  ),
                ],
              ),
              child: DropdownButton<String>(
                value: selectedValue,
                hint: const Text("Select an option"),
                isExpanded: true,
                underline: const SizedBox(),
                items: items.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedValue = value;
                  });
                },
              ),
            ),

            const SizedBox(height: 30),
            Container(
              height: 60,
              width: 350,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(7, 7),
                    blurRadius: 10,
                    color: const Color.fromARGB(154, 0, 0, 0),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Container(
              height: 390,
              width: 350,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(7, 7),
                    blurRadius: 10,
                    color: const Color.fromARGB(154, 0, 0, 0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
