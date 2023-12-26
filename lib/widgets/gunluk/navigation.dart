import 'package:bitirme_projesi/widgets/gunluk/kaydedilen_ogunlar_page.dart';
import 'package:bitirme_projesi/widgets/gunluk/yemek_tarifleri_ekrani.dart';
import 'package:flutter/material.dart';

class Navigation extends StatelessWidget {
  const Navigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => YemekTarifleriPage()),
              );
            },
            child: Text(
              'Yemek Tarifleri',
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
          ),
          SizedBox(width: 30), // Burada bir boşluk ekledik

          GestureDetector(
            onTap: () {
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
    );
  }
}
