import 'package:flutter/material.dart';
import 'package:bitirme_projesi/widgets/gunluk/fav_widget.dart';
import 'package:bitirme_projesi/screens/gunluk/model.dart';

class KaydedilenOgunlerPage extends StatefulWidget {
  final List<RecipeModel> recipeList;
  final Function getFavorites;
  final List<String> favorites;

  KaydedilenOgunlerPage(
      {required this.recipeList,
      required this.getFavorites,
      required this.favorites});

  @override
  _KaydedilenOgunlerPageState createState() => _KaydedilenOgunlerPageState();
}

class _KaydedilenOgunlerPageState extends State<KaydedilenOgunlerPage> {
  @override
  void initState() {
    super.initState();
    // Favori tarifleri getirmek için ilgili fonksiyonu çağır
    widget.getFavorites();
  }

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
