import 'package:bitirme_projesi/widgets/gunluk/navigation.dart';
import 'package:flutter/material.dart';

Widget MyText() {
  return Text("my text widget is here");
}

class KahvaltiPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white70,
        title: Text('Kahvaltı Sayfası'),
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
