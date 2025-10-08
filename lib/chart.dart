import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class Chart extends StatefulWidget {
  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
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

  final List<double> values = [5, 10, 7, 12, 9, 4, 6, 8, 11, 3, 10, 6, 7, 9];

  final List<Color> colors = [
    Color(0xFFFF6F61),
    Color(0xFFFFB347),
    Color(0xFFFFD700),
    Color(0xFF6BCB77),
    Color(0xFF4D96FF),
    Color(0xFF845EC2),
    Color(0xFFFF7F50),
    Color(0xFF00C9A7),
    Color(0xFFFFC75F),
    Color(0xFFB29700),
    Color(0xFF8ED081),
    Color(0xFFAF7AC5),
    Color(0xFFFF91A4),
    Color(0xFFFFABAB),
  ];

  int? touchedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 186, 241, 253),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 460,
              height: 460,
              child: PieChart(
                PieChartData(
                  sectionsSpace: 2,
                  centerSpaceRadius: 60,
                  pieTouchData: PieTouchData(
                    touchCallback: (event, response) {
                      setState(() {
                        if (response != null &&
                            response.touchedSection != null) {
                          touchedIndex =
                              response.touchedSection!.touchedSectionIndex;
                        } else {
                          touchedIndex = null;
                        }
                      });
                    },
                  ),
                  sections: List.generate(14, (index) {
                    final isTouched = index == touchedIndex;
                    final double radius = isTouched ? 130 : 110;

                    return PieChartSectionData(
                      color: colors[index],
                      value: values[index],
                      radius: radius,
                      title: isTouched ? '${values[index]}' : '',
                      titleStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    );
                  }),
                ),
              ),
            ),
            SizedBox(height: 20),
            if (touchedIndex != null &&
                touchedIndex! >= 0 &&
                touchedIndex! < labels.length)
              Text(
                labels[touchedIndex!],
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
          ],
        ),
      ),
    );
  }
}
