import 'package:flutter/material.dart';

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
