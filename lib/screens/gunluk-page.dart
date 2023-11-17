import 'package:flutter/material.dart';

class GunlukPage extends StatefulWidget {
  @override
  _GunlukPageState createState() => _GunlukPageState();
}

class _GunlukPageState extends State<GunlukPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Günlük'),
        backgroundColor:
            Colors.deepPurple, // AppBar'ın arka plan rengini beyaz yapar
        foregroundColor: Colors.white70,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(Icons.fastfood), // Kahvaltı simgesi
                  SizedBox(width: 8), // Simgeler arasında boşluk
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        primary: Colors.deepPurple[200],
                        onPrimary: Colors.black,
                      ),
                      child: Text('Kahvaltı'),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Icon(Icons.restaurant_menu), // Öğle yemeği simgesi
                  SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        primary: Colors.deepPurple[200],
                        onPrimary: Colors.black,
                      ),
                      child: Text('Öğle Yemeği'),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Icon(Icons.dinner_dining), // Akşam yemeği simgesi
                  SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        primary: Colors.deepPurple[200],
                        onPrimary: Colors.black,
                      ),
                      child: Text('Akşam Yemeği'),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Icon(Icons.local_dining), // Aperatifler simgesi
                  SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        primary: Colors.deepPurple[200],
                        onPrimary: Colors.black,
                      ),
                      child: Text('Aperatifler/Diğer'),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Icon(Icons.directions_run), // Egzersiz simgesi
                  SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        primary: Colors.deepPurple[200],
                        onPrimary: Colors.black,
                      ),
                      child: Text('Egzersiz/Uyku Ekle'),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Icon(Icons.settings), // Öğünleri özelleştirme simgesi
                  SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        primary: Colors.deepPurple[200],
                        onPrimary: Colors.black,
                      ),
                      child: Text('Öğünleri Özelleştir(P*)'),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Icon(Icons.local_drink), // Su içme takipçisi simgesi
                  SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        primary: Colors.deepPurple[200],
                        onPrimary: Colors.black,
                      ),
                      child: Text('Su İçme Takipçisi(P*)'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
