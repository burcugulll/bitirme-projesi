import 'package:flutter/material.dart';
import 'package:bitirme_projesi/screens/premium_page.dart'; // Premium sayfasının import edildiğinden emin olun

class CustomButtonRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget page;

  CustomButtonRow(
      {required this.icon, required this.title, required this.page});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(icon),
        SizedBox(width: 8),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              // Öğünleri özelleştir veya su içme takipçisi sayfalarına tıklanırsa
              if (title == 'Öğünleri Özelleştir(P*)' ||
                  title == 'Su İçme Takipçisi(P*)') {
                // Premium sayfasına yönlendir
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          PremiumPage()), // Premium sayfasının doğru adını kullanın
                );
              } else {
                // Diğer sayfalara yönlendir
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => page),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.deepPurple[200],
              onPrimary: Colors.black,
            ),
            child: Text(title),
          ),
        ),
      ],
    );
  }
}
