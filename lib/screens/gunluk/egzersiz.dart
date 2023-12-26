import 'dart:convert';

import 'package:bitirme_projesi/widgets/alert_message.dart';
import 'package:bitirme_projesi/widgets/gunluk/exercise_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:toastification/toastification.dart';

class EgzersizPage extends StatefulWidget {
  const EgzersizPage({Key? key}) : super(key: key);

  @override
  State<EgzersizPage> createState() => _EgzersizPageState();
}

class ExerciseModel {
  final String isim;
  final String tip;
  final String kas;
  final String ekipman;
  final String zorluk;
  final String talimatlar;

  ExerciseModel({
    required this.isim,
    required this.tip,
    required this.kas,
    required this.ekipman,
    required this.zorluk,
    required this.talimatlar,
  });

  factory ExerciseModel.fromJson(Map<String, dynamic> json) {
    return ExerciseModel(
      isim: json['isim'],
      tip: json['tip'],
      kas: json['kas'],
      ekipman: json['ekipman'],
      zorluk: json['zorluk'],
      talimatlar: json['talimatlar'],
    );
  }
}

class _EgzersizPageState extends State<EgzersizPage> {
  List<ExerciseModel> exerciseList = <ExerciseModel>[];
  bool isLoading = true;
  String selectedExercise = "omuz";
  List<String> exercises = [
    "on_kol",
    "karin",
    "gogus",
    "kalf",
    "kalca",
    "arka_bacak",
    "sirt",
    "bel",
    "omuz",
    "arka_kol",
    "ic_bacak",
    "boyun"
  ];

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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: DropdownButton<String>(
                isExpanded: true,
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
                style: TextStyle(fontSize: 16.0, color: Colors.black87),
                underline: Container(),
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
