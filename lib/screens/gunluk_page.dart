import 'package:bitirme_projesi/screens/gunluk/aksam.dart';
import 'package:bitirme_projesi/screens/gunluk/aperatif.dart';
import 'package:bitirme_projesi/screens/gunluk/egzersiz.dart';
import 'package:bitirme_projesi/screens/gunluk/kahvalti.dart';
import 'package:bitirme_projesi/screens/gunluk/ogle.dart';

import 'package:bitirme_projesi/widgets/gunluk/custom_row_button.dart';
import 'package:flutter/material.dart';

class GunlukPage extends StatefulWidget {
  @override
  _GunlukPageState createState() => _GunlukPageState();
}

final List<Map<String, dynamic>> buttonData = [
  {'icon': Icons.fastfood, 'title': 'Kahvaltı', 'page': KahvaltiPage()},
  {'icon': Icons.restaurant_menu, 'title': 'Öğle Yemeği', 'page': OglePage()},
  {'icon': Icons.dinner_dining, 'title': 'Akşam Yemeği', 'page': AksamPage()},
  {'icon': Icons.local_dining, 'title': 'Aperatifler', 'page': AperatifPage()},
  {
    'icon': Icons.directions_run,
    'title': 'Egzersizler',
    'page': EgzersizPage()
  },
  {
    'icon': Icons.settings,
    'title': 'Öğünleri Özelleştir(P*)',
    'page': KahvaltiPage()
  },
  {
    'icon': Icons.local_drink,
    'title': 'Su İçme Takipçisi(P*)',
    'page': KahvaltiPage()
  },
];

class _GunlukPageState extends State<GunlukPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Günlük'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white70,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: buttonData.map((data) {
                return CustomButtonRow(
                  icon: data['icon'],
                  title: data['title'],
                  page: data['page'],
                );
              }).toList()),
        ),
      ),
    );
  }
}
