import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class RaporlarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yemek ve Egzersiz Dağılımı'),
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white70,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: PieChart(
          PieChartData(
            sectionsSpace: 0,
            centerSpaceRadius: 40,
            sections: [
              PieChartSectionData(
                color: Colors.tealAccent,
                value: 40,
                title: 'Yemek',
                radius: 50,
                titleStyle:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              PieChartSectionData(
                color: Color.fromARGB(255, 141, 96, 230),
                value: 60,
                title: 'Egzersiz',
                radius: 50,
                titleStyle:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: RaporlarPage(),
  ));
}
