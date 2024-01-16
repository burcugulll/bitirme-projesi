import 'package:bitirme_projesi/screens/gunluk/model.dart';
import 'package:bitirme_projesi/services/firebase_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FavoriKalp extends StatefulWidget {
  final bool isFavorited;

  final RecipeModel recipe;

  FavoriKalp({required this.recipe, required this.isFavorited});

  @override
  _FavoriKalpState createState() => _FavoriKalpState();
}

class _FavoriKalpState extends State<FavoriKalp> {
  bool _isFavorited = false;
  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    _isFavorited = widget.isFavorited;
  }

  Future<void> addRecipeToFavorites() async {
    try {
      //firebase favorites collectionuna email ile tarifi kaydet.
      FirebaseServices firebase = FirebaseServices();
      final existingFavorite = await firebase.favorites
          .where("url", isEqualTo: widget.recipe.appurl)
          .get();
      if (existingFavorite.docs.isEmpty) {
        await firebase.favorites.add({
          'email': user?.email,
          'name': widget.recipe.applabel,
          'imageUrl': widget.recipe.appimgUrl,
          'calories': widget.recipe.appcalories.toInt(),
          'url': widget.recipe.appurl,
        });
      } else {
        await firebase.favorites.doc(existingFavorite.docs[0].id).delete();
      }
    } catch (e) {
      print("Hata oluştu: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        _isFavorited ? Icons.favorite : Icons.favorite_border,
        color: _isFavorited ? Colors.red : null,
      ),
      onPressed: () async {
        setState(() {
          _isFavorited = !_isFavorited;
        });
        await addRecipeToFavorites();
      },
    );
  }
}
