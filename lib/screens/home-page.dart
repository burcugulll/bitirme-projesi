import 'package:flutter/material.dart';
import "package:bitirme_projesi/screens/gunluk-page.dart";

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex =
      0; // Başlangıçta seçili olan ögeyi belirtmek için kullanılır
  static const List<Widget> _widgetOptions = <Widget>[
    Text('Ana Sayfa'),
    Text('Profil'),
    Text('Günlük'),
    Text('Raporlar'),
    Text('Premium'),
  ];

  void _onItemTapped(int index) {
    if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GunlukPage(),
        ),
      );
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ana Sayfa'),
        backgroundColor:
            Colors.deepPurple, // AppBar'ın arka plan rengini beyaz yapar
        foregroundColor: Colors.white70,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Ana Sayfa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Günlük',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Raporlar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Premium',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue, // Seçili ögenin rengi
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed, // Tüm etiketleri zorla
      ),
    );
  }
}
