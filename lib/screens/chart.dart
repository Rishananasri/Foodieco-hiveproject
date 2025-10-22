import 'dart:developer'; 
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pr/models/recipe_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Chart extends StatefulWidget {
  const Chart({super.key});

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  int touchedIndex = -1;
  String currentUser = "";

  final List<String> labels = [
    "Starters",
    "Snacks",
    "Desserts",
    "Drinks",
    "Seafood",
    "Breads",
    "Pasta",
    "Rice",
    "Curry",
    "Salads",
    "Soups",
    "Fast Food",
    "Grill",
    "Sides",
  ];

  final List<Color> colors = [
    Color(0xFFB2EBF2),
    Color(0xFF6C7A89),
    Color(0xFFDCE775),
    Color(0xFF27408B),
    Color(0xFFB0E0E6),
    Color(0xFF3F51B5),
    Color(0xFF87A8A4),
    Color(0xFFFFE0B2),
    Color(0xFF00ACC1),
    Color(0xFF4682B4),
    Color(0xFF87CEEB),
    Color.fromARGB(255, 247, 206, 70),
    Color(0xFF003153),
    Color(0xFF4682B4),
  ];

  @override
  void initState() {
    super.initState();
    _loadCurrentUser();
    log("Chart page initialized", name: "ChartPage");
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
      body: ValueListenableBuilder(
        valueListenable: recipeBox.listenable(),
        builder: (context, Box<RecipeModel> box, _) {
          Map<String, int> categoryCounts = {};
          for (var label in labels) {
            categoryCounts[label] = box.values
                .where((r) => r.category == label && r.username == currentUser)
                .length;
          }

          final filteredLabels = labels
              .where((l) => categoryCounts[l]! > 0)
              .toList();
          final filteredValues = filteredLabels
              .map((l) => categoryCounts[l]!.toDouble())
              .toList();
          final filteredColors = colors.take(filteredLabels.length).toList();

          // log("Filtered labels: $filteredLabels", name: "ChartPage");
          // log("Filtered values: $filteredValues", name: "ChartPage");

          if (filteredLabels.isEmpty) {
            log(
              "No recipes found for current user: $currentUser",
              name: "ChartPage",
              level: 900,
            );
            return Center(
              child: Image.asset("assets/images/Your paragraph text (6).png"),
            );
          }

          final mid = (filteredLabels.length / 2).ceil();
          final firstHalf = List.generate(mid, (i) => i);
          final secondHalf = List.generate(
            filteredLabels.length - mid,
            (i) => i + mid,
          );

          return Column(
            children: [
              Spacer(),
              Center(
                child: SizedBox(
                  width: 400,
                  height: 400,
                  child: PieChart(
                    PieChartData(
                      sectionsSpace: 2,
                      centerSpaceRadius: 50,
                      pieTouchData: PieTouchData(
                        touchCallback: (event, response) {
                          if (response == null ||
                              response.touchedSection == null) {
                            setState(() => touchedIndex = -1);
                            log("Pie chart touch cleared", name: "ChartPage");
                            return;
                          }
                          setState(() {
                            touchedIndex =
                                response.touchedSection!.touchedSectionIndex;
                          });
                          log(
                            "Pie chart section touched: ${filteredLabels[touchedIndex]} with value ${filteredValues[touchedIndex]}",
                            name: "ChartPage",
                          );
                        },
                      ),
                      sections: List.generate(filteredLabels.length, (i) {
                        final isTouched = i == touchedIndex;
                        final radius = isTouched ? 130.0 : 110.0;
                        return PieChartSectionData(
                          color: filteredColors[i],
                          value: filteredValues[i],
                          title: isTouched
                              ? '${filteredValues[i].toInt()}'
                              : '',
                          radius: radius,
                          titleStyle: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                          titlePositionPercentageOffset: 0.6,
                        );
                      }),
                    ),
                  ),
                ),
              ),
               SizedBox(height: 20),
              Text(
                touchedIndex >= 0 ? filteredLabels[touchedIndex] : '',
                style:  TextStyle(
                  fontSize: 18,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
               SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: firstHalf.map((i) {
                      return Padding(
                        padding:  EdgeInsets.symmetric(vertical: 6),
                        child: Row(
                          children: [
                            Container(
                              width: 16,
                              height: 16,
                              decoration: BoxDecoration(
                                color: filteredColors[i],
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                             SizedBox(width: 8),
                            Text(
                              '${filteredLabels[i]} ',
                              style:  TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                   SizedBox(width: 100),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: secondHalf.map((i) {
                      return Padding(
                        padding:  EdgeInsets.symmetric(vertical: 6),
                        child: Row(
                          children: [
                            Container(
                              width: 16,
                              height: 16,
                              decoration: BoxDecoration(
                                color: filteredColors[i],
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                             SizedBox(width: 8),
                            Text(
                              '${filteredLabels[i]} ',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
              Spacer(),
            ],
          );
        },
      ),
    );
  }
}
