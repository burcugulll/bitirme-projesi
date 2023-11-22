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
  bool isLoading = true; // Yeni bir isLoading durumu ekledik.
  String exercise = "biceps";

/*
  Future<void> _fetchExerciseData() async {
    String muscle = Uri.encodeQueryComponent("triceps");
    String apiUrl = "https://api.api-ninjas.com/v1/exercises?muscle=$muscle";

    var headers = {
      'X-Api-Key': '64LlWR1Gr/Dw2iF46o505Q==KZL1aOjWVRX1pfrl',
    };

    try {
      final response = await http.get(Uri.parse(apiUrl), headers: headers);

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        List<ExerciseModel> updatedExerciseList =
            data.map((exercise) => ExerciseModel.fromJson(exercise)).toList();

        setState(() {
          exerciseList = updatedExerciseList;
          isLoading =
              false; // Loading tamamlandığında isLoading durumunu güncelledik.
        });

        print("başarılı");
        AlertMessage(
            alertType: ToastificationType.success,
            message: "Egzersizler Başarıyla Getirildi.",
            context: context);
      } else {
        print('HTTP isteği başarısız oldu: ${response.statusCode}');
        isLoading = false; // Hata durumunda da isLoading durumunu güncelledik.
      }
    } catch (error) {
      print('Hata oluştu: $error');

      isLoading = false; // Hata durumunda da isLoading durumunu güncelledik.
    }
  }
*/

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
    _fetchExerciseData(exercise: exercise);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Egzersiz Sayfası'),
      ),
      body: isLoading
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
    );
  }
}
