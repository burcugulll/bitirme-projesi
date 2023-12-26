import "package:bitirme_projesi/screens/gunluk/egzersiz.dart";
import "package:flutter/material.dart";

class ExerciseListItem extends StatelessWidget {
  final ExerciseModel exercise;
  final BuildContext context;

  ExerciseListItem({required this.exercise, required this.context});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          _showExerciseDetails(context);
        },
        child: Card(
          elevation: 3.0,
          margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exercise.isim,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Row(
                  children: [
                    Icon(Icons.fitness_center),
                    SizedBox(width: 8.0),
                    Text(
                      'Kas: ${exercise.kas}',
                      style: TextStyle(fontSize: 14.0),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.accessibility),
                    SizedBox(width: 8.0),
                    Text(
                      'Ekipman: ${exercise.ekipman}',
                      style: TextStyle(fontSize: 14.0),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.star),
                    SizedBox(width: 8.0),
                    Text(
                      'Zorluk: ${exercise.zorluk}',
                      style: TextStyle(fontSize: 14.0),
                    ),
                  ],
                ),
                SizedBox(height: 12.0),
                Text(
                  'Talimatlar:',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.0),
                _buildShortenedInstructions(exercise.talimatlar),
              ],
            ),
          ),
        ));
  }

  Widget _buildShortenedInstructions(String instructions) {
    const int maxLength = 100;
    if (instructions.length <= maxLength) {
      return Text(
        instructions,
        style: TextStyle(fontSize: 14.0),
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              instructions.substring(0, maxLength) + '...',
              style: TextStyle(fontSize: 14.0),
            ),
          ),
          InkWell(
            onTap: () {
              _showExerciseDetails(context);
            },
            child: Text(
              'Daha fazlasını görmek için tıklayın',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      );
    }
  }

  void _showExerciseDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(bottom: 20, top: 20, left: 16, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exercise.isim,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Tip: ${exercise.tip}',
                  style: TextStyle(fontSize: 14.0),
                ),
                Text(
                  'Kas: ${exercise.kas}',
                  style: TextStyle(fontSize: 14.0),
                ),
                Text(
                  'Ekipman: ${exercise.ekipman}',
                  style: TextStyle(fontSize: 14.0),
                ),
                Text(
                  'Zorluk: ${exercise.zorluk}',
                  style: TextStyle(fontSize: 14.0),
                ),
                SizedBox(height: 12.0),
                Text(
                  'Talimatlar:',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  exercise.talimatlar,
                  style: TextStyle(fontSize: 14.0),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
