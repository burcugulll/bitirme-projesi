import 'package:flutter/material.dart';

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
