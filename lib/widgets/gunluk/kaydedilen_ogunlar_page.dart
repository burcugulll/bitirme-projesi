import 'package:bitirme_projesi/services/firebase_services.dart';
import 'package:bitirme_projesi/widgets/web_view_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bitirme_projesi/widgets/gunluk/fav_widget.dart';
import 'package:bitirme_projesi/screens/gunluk/model.dart';

class KaydedilenOgunlerPage extends StatefulWidget {
  @override
  _KaydedilenOgunlerPageState createState() => _KaydedilenOgunlerPageState();
}

class _KaydedilenOgunlerPageState extends State<KaydedilenOgunlerPage> {
  List<FBRecipeModel> favorites = [];
  List<String> favoriteNames = [];
  FirebaseServices firebase = FirebaseServices();

  getFavorites() async {
    try {
      // Kullanıcının favori tariflerini Firebase Firestore'dan al
      final user = await FirebaseAuth.instance.currentUser;
      print(user?.email);

      // Kullanıcı oturumu açık değilse veya kullanıcı verisi alınamıyorsa işlemi sonlandır
      if (user == null) {
        return;
      }

      final favs =
          await firebase.favorites.where("email", isEqualTo: user?.email).get();

      if (favs.docs.isEmpty) {
        return;
      }

      // Firestore'dan gelen verileri FBRecipeModel türüne dönüştürerek listeye ekle
      setState(() {
        favorites = favs.docs
            .map((doc) => FBRecipeModel.fromMap(doc.data() as Map))
            .toList();

        favoriteNames = favs.docs.map((doc) => doc['name'] as String).toList();
      });

      print(favs.docs.length);
    } catch (error) {
      print('Favori tarifleri getirirken hata oluştu: $error');
      // Hata durumunda boş bir liste döndür
      return [];
    }
  }

  @override
  void initState() {
    super.initState();

    getFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favoriler Sayfası'),
      ),
      body: favorites.isEmpty
          ? Center(
              child: Text('Henüz kaydedilen öğün bulunmamaktadır.'),
            )
          : Container(
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: favorites.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WebViewContainer(
                            url: favorites[index].url,
                            recipe: favorites[index].name,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      margin: EdgeInsets.all(20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 0.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ClipRect(
                            child: Image.network(
                              favorites[index].imageUrl,
                              fit: BoxFit.cover,
                              height: 200,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            color: Colors.black,
                            child: Text(
                              favorites[index].name,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.local_fire_department, size: 20),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                      favorites[index]
                                              .calories
                                              .round()
                                              .toString() +
                                          " cal",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                FavoriKalp(
                                  recipe: RecipeModel(
                                      appurl: favorites[index].url,
                                      appcalories: favorites[index].calories,
                                      appimgUrl: favorites[index].imageUrl,
                                      applabel: favorites[index].name),
                                  isFavorited: favoriteNames
                                      .contains(favorites[index].name),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
      backgroundColor: Colors.grey[200],
    );
  }
}
