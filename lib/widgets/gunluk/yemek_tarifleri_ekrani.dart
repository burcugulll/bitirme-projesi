// ignore_for_file: file_names

import 'package:bitirme_projesi/services/firebase_services.dart';
import 'package:bitirme_projesi/widgets/alert_message.dart';
import 'package:bitirme_projesi/widgets/gunluk/recipe_view.dart';
import 'package:bitirme_projesi/widgets/web_view_container.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart';
import 'package:bitirme_projesi/screens/gunluk/model.dart';
import 'package:toastification/toastification.dart';
import 'package:bitirme_projesi/widgets/gunluk/fav_widget.dart';

class YemekTarifleriPage extends StatefulWidget {
  @override
  _YemekTarifleriPageState createState() => _YemekTarifleriPageState();
}

class _YemekTarifleriPageState extends State<YemekTarifleriPage> {
  List<RecipeModel> recipeList = <RecipeModel>[];
  TextEditingController searchController = TextEditingController();
  FirebaseServices firebase = FirebaseServices();
  final user = FirebaseAuth.instance.currentUser;

  List<String> favorites = [];

  getRecipes(String query) async {
    try {
      String url =
          'https://api.edamam.com/search?q=$query&app_id=9dbf4610&app_key=0e45552529bb0b4cb1d5c8232226f7ed';

      Response response = await get(Uri.parse(url));

      if (response.statusCode == 200) {
        dynamic responseData = jsonDecode(response.body);

        if (responseData is Map<String, dynamic> &&
            responseData.containsKey("hits")) {
          List<RecipeModel> updatedRecipeList = [];

          responseData["hits"].forEach((element) {
            RecipeModel recipeModel = RecipeModel.fromMap(element["recipe"]);
            updatedRecipeList.add(recipeModel);
            log(updatedRecipeList.toString());
          });

          setState(() {
            recipeList = updatedRecipeList;
          });
          AlertMessage(
            alertType: ToastificationType.success,
            message: "Yemek Tarifleri Başarıyla Getirildi.",
            context: context,
          );
        } else {
          print('Beklenmeyen API yanıt formatı.');
        }
      } else {
        print('HTTP isteği başarısız oldu: ${response.statusCode}');
      }
    } catch (error) {
      print('Hata oluştu: $error');
    }
  }

  getFavorites() async {
    try {
      // Kullanıcının favori tariflerini Firebase Firestore'dan al
      final favs =
          await firebase.favorites.where("email", isEqualTo: user?.email).get();

      if (favs.docs.isEmpty) {
        // Eğer favori tarif yoksa boş bir liste döndür
        return [];
      }

      // Favori tariflerin isimlerini içeren bir string listesi oluştur
      List<String> favoriteNames =
          favs.docs.map((doc) => doc['name'] as String).toList();

      // Oluşturulan string listesini state içindeki 'favorites' listesine atayarak güncelle
      setState(() {
        favorites = favoriteNames;
      });

      // Favori tarif isimlerini döndür
      return favoriteNames;
    } catch (error) {
      print('Favori tarifleri getirirken hata oluştu: $error');
      // Hata durumunda boş bir liste döndür
      return [];
    }
  }

  @override
  void initState() {
    super.initState();
    getRecipes("cake");
    getFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yemek Tarifleri Sayfası'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white70,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey,
                            size: 34.0,
                          ),
                          hintText: 'Yemek Tarifleri Ara',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if ((searchController.text).replaceAll(" ", "") == "") {
                          print("Blank search");
                        } else {
                          getRecipes(searchController.text);
                        }
                      },
                      child: Text('Tarifleri Ara'),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: recipeList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WebViewContainer(
                            url: recipeList[index].appurl,
                            recipe: recipeList[index].applabel,
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
                              recipeList[index].appimgUrl,
                              fit: BoxFit.cover,
                              height: 200,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            color: Colors.black,
                            child: Text(
                              recipeList[index].applabel,
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
                                      recipeList[index]
                                              .appcalories
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
                                  recipe: recipeList[index],
                                  isFavorited: favorites.contains(
                                      recipeList[index]
                                          .applabel), // Başlangıç durumu
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
          ],
        ),
      ),
    );
  }
}
