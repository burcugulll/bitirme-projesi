import 'package:bitirme_projesi/widgets/gunluk/yemek-tarifleri-ekrani.dart';
import 'package:bitirme_projesi/widgets/gunluk/kaydedilen-ogunlar-page.dart';
import 'package:bitirme_projesi/widgets/gunluk/yemek-page.dart';
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
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    // Yemek sayfasına yönlendirme
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => YemekPage()),
                    );
                  },
                  child: Text(
                    'Yemek',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Yemek Tarifleri sayfasına yönlendirme
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => YemekTarifleriPage()),
                    );
                  },
                  child: Text(
                    'Yemek Tarifleri',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Kaydedilen Öğünler sayfasına yönlendirme
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => KaydedilenOgunlerPage()),
                    );
                  },
                  child: Text(
                    'Kaydedilen Öğünler',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
          // Diğer sayfa içerikleri buraya eklenebilir.
        ],
      ),
    );
  }
}
