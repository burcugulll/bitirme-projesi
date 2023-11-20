import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Egzersiz Sayfası'),
      ),
      body: FutureBuilder(
        future: _fetchExerciseData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Hata oluştu: ${snapshot.error}'),
            );
          } else {
            return ListView.builder(
              itemCount: exerciseList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(exerciseList[index].name),
                  subtitle: Text(exerciseList[index].instructions),
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<void> _fetchExerciseData() async {
    String muscle = Uri.encodeQueryComponent("biceps");
    String apiUrl = "https://api.api-ninjas.com/v1/exercises?muscle=$muscle";

    var headers = {
      'Content-Type': 'application/json',
      'X-Api-Key': 'fb71fbac26mshcaedce11afce2fbp12baafjsnaa55768185f5',
    };

    try {
      final response = await http.get(Uri.parse(apiUrl), headers: headers);

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        List<ExerciseModel> updatedExerciseList =
            data.map((exercise) => ExerciseModel.fromJson(exercise)).toList();

        setState(() {
          exerciseList = updatedExerciseList;
        });
      } else {
        print('HTTP isteği başarısız oldu: ${response.statusCode}');
      }
    } catch (error) {
      print('Hata oluştu: $error');
    }
  }
}
