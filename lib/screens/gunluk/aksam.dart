import 'package:bitirme_projesi/widgets/gunluk/navigation.dart';
import 'package:flutter/material.dart';
import 'package:bitirme_projesi/widgets/gunluk/yemek-tarifleri-ekrani.dart';
import 'package:bitirme_projesi/widgets/gunluk/kaydedilen-ogunlar-page.dart';
import 'package:bitirme_projesi/widgets/gunluk/yemek-page.dart';

class AksamPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white70,
        title: Text('Akşam Yemeği Sayfası'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[Navigation()],
            ),
          ),
        ],
      ),
    );
  }
}
