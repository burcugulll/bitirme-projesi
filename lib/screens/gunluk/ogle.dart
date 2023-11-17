import 'package:flutter/material.dart';

class OglePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white70,
        title: Text('Öğle Yemeği Sayfası'),
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

class YemekPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yemek Sayfası'),
      ),
      body: Center(
        child: Text('Burada yemek içeriği bulunabilir.'),
      ),
    );
  }
}

class YemekTarifleriPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yemek Tarifleri Sayfası'),
      ),
      body: Center(
        child: Text('Burada yemek tarifleri içeriği bulunabilir.'),
      ),
    );
  }
}

class KaydedilenOgunlerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kaydedilen Öğünler Sayfası'),
      ),
      body: Center(
        child: Text('Burada kaydedilen öğünler içeriği bulunabilir.'),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}
