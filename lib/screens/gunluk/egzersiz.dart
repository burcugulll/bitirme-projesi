import 'dart:convert';

import 'package:bitirme_projesi/widgets/alert-message.dart';
import 'package:bitirme_projesi/widgets/gunluk/exercise-list-item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:toastification/toastification.dart';

class EgzersizPage extends StatefulWidget {
  const EgzersizPage({Key? key}) : super(key: key);

  @override
  State<EgzersizPage> createState() => _EgzersizPageState();
}

class ExerciseModel {
  final String name;
  final String type;
  final String muscle;
  final String equipment;
  final String difficulty;
  final String instructions;

  ExerciseModel({
    required this.name,
    required this.type,
    required this.muscle,
    required this.equipment,
    required this.difficulty,
    required this.instructions,
  });

  factory ExerciseModel.fromJson(Map<String, dynamic> json) {
    return ExerciseModel(
      name: json['name'],
      type: json['type'],
      muscle: json['muscle'],
      equipment: json['equipment'],
      difficulty: json['difficulty'],
      instructions: json['instructions'],
    );
  }
}

class _EgzersizPageState extends State<EgzersizPage> {
  List<ExerciseModel> exerciseList = <ExerciseModel>[];
  bool isLoading = true;
  String selectedExercise = "biceps"; // Default selected exercise
  List<String> exercises = [
    "biceps",
    "abdominals",
    "chest",
    "calves",
    "forearms",
    "glutes",
    "hamstrings",
    "lats",
    "lower_back",
    "traps",
    "triceps",
    "abductors",
    "adductors",
    "neck",
    "quadriceps"
  ]; // Add other exercises as needed

  Future<void> _fetchExerciseData({required exercise}) async {
    try {
      String jsonData =
          await rootBundle.loadString('assets/exercises/$exercise.json');
      List<dynamic> data = json.decode(jsonData);

      List<ExerciseModel> updatedExerciseList =
          data.map((exercise) => ExerciseModel.fromJson(exercise)).toList();

      setState(() {
        exerciseList = updatedExerciseList;
        isLoading = false;
      });

      print("Başarılı");
      AlertMessage(
          alertType: ToastificationType.success,
          message: "Egzersizler Başarıyla Getirildi.",
          context: context);
    } catch (error) {
      print('Hata oluştu: $error');
      isLoading = false;
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchExerciseData(exercise: selectedExercise);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Egzersiz Sayfası'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white70,
      ),
      body: Column(
        children: [
          // Dropdown to select exercises
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Container(
              width: double.infinity, // Make the container full width
              decoration: BoxDecoration(
                border:
                    Border.all(color: Colors.grey), // Add border for styling
                borderRadius:
                    BorderRadius.circular(8.0), // Add border radius for styling
              ),
              child: DropdownButton<String>(
                isExpanded: true, // Make the dropdown button full width
                value: selectedExercise,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedExercise = newValue!;
                    isLoading = true;
                  });
                  _fetchExerciseData(exercise: selectedExercise);
                },
                items: exercises.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(value),
                    ),
                  );
                }).toList(),
                style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black87), // Customize text style
                underline: Container(), // Remove the default underline
              ),
            ),
          ),

          Expanded(
            child: isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : exerciseList.isEmpty
                    ? Center(
                        child: Text('Veri bulunamadı.'),
                      )
                    : ListView.builder(
                        itemCount: exerciseList.length,
                        itemBuilder: (context, index) {
                          return ExerciseListItem(
                            exercise: exerciseList[index],
                            context: context,
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
