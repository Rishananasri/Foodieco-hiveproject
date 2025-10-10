import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class Chart extends StatefulWidget {
  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  int touchedIndex = -1;

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

  @override
  Widget build(BuildContext context) {
    final mid = (labels.length / 2).ceil();
    final firstHalf = List.generate(mid, (i) => i);
    final secondHalf = List.generate(labels.length - mid, (i) => i + mid);

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 186, 241, 253),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Spacer(),
            Center(
              child: SizedBox(
                width: 460,
                height: 460,
                child: PieChart(
                  PieChartData(
                    sectionsSpace: 2,
                    centerSpaceRadius: 60,
                    pieTouchData: PieTouchData(
                      touchCallback: (event, response) {
                        if (response == null ||
                            response.touchedSection == null) {
                          setState(() => touchedIndex = -1);
                          return;
                        }
                        setState(() {
                          touchedIndex =
                              response.touchedSection!.touchedSectionIndex;
                        });
                      },
                    ),
                    sections: buildSections(),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Text(
              touchedIndex >= 0 ? ' ${labels[touchedIndex]}' : '',
              style: TextStyle(fontSize: 20, color: Colors.black87),
            ),

            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: firstHalf.map((i) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 6,
                      ), 
                      child: Row(
                        children: [
                          Container(
                            width: 18,
                            height: 18,
                            decoration: BoxDecoration(
                              color: colors[i],
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            labels[i],
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),

                SizedBox(
                  width: 130,
                ), 
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: secondHalf.map((i) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 6,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 18,
                            height: 18,
                            decoration: BoxDecoration(
                              color: colors[i],
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            labels[i],
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
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
        ),
      ),
    );
  }

  List<PieChartSectionData> buildSections() {
    return List.generate(labels.length, (i) {
      final bool isTouched = i == touchedIndex;
      final double radius = isTouched ? 130 : 110;

      return PieChartSectionData(
        color: colors[i],
        value: values[i],
        title: isTouched ? '${values[i]}' : '',
        radius: radius,
        titleStyle: TextStyle(fontSize: 16, color: Colors.white),
        titlePositionPercentageOffset: 0.6,
      );
    });
  }
}
