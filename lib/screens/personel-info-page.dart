import 'package:flutter/material.dart';
import "package:bitirme_projesi/screens/goal-selection-page.dart";

class PersonalInfoPage extends StatefulWidget {
  @override
  State<PersonalInfoPage> createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kişisel Bilgiler'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Ad',
                ),
              ),
              TextField(
                controller: surnameController,
                decoration: InputDecoration(
                  labelText: 'Soyad',
                ),
              ),
              TextField(
                controller: genderController,
                decoration: InputDecoration(
                  labelText: 'Cinsiyet',
                ),
              ),
              TextField(
                controller: birthDateController,
                decoration: InputDecoration(
                  labelText: 'Doğum Tarihi',
                ),
              ),
              TextField(
                controller: heightController,
                decoration: InputDecoration(
                  labelText: 'Boy',
                ),
              ),
              TextField(
                controller: weightController,
                decoration: InputDecoration(
                  labelText: 'Kilo',
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Kişisel bilgileri kaydetme veya işleme adımlarını burada gerçekleştirebilirsiniz.
                  // Örnek olarak, bu verileri yazdırabiliriz:
                  print('Ad: ${nameController.text}');
                  print('Soyad: ${surnameController.text}');
                  print('Cinsiyet: ${genderController.text}');
                  print('Doğum Tarihi: ${birthDateController.text}');
                  print('Boy: ${heightController.text}');
                  print('Kilo: ${weightController.text}');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GoalSelectionPage(),
                    ),
                  );
                },
                child: Text('Bilgileri Kaydet'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
