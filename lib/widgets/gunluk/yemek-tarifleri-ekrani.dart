import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart';
import 'package:bitirme_projesi/screens/gunluk/model.dart';

class YemekTarifleriPage extends StatefulWidget {
  @override
  _YemekTarifleriPageState createState() => _YemekTarifleriPageState();
}

class _YemekTarifleriPageState extends State<YemekTarifleriPage> {
  List<RecipeModel> recipeList = <RecipeModel>[];
  TextEditingController searchController = TextEditingController();

  getRecipes(String query) async {
    String url =
        'https://api.edamam.com/search?q=$query&app_id=9dbf4610&app_key=0e45552529bb0b4cb1d5c8232226f7ed';
    Response response = await get(Uri.parse(url));
    Map data = jsonDecode(response.body);

    data["hits"].forEach((element) {
      RecipeModel recipeModel = RecipeModel.fromMap(element["recipe"]);
      recipeList.add(recipeModel);
      log(recipeList.toString());
    });

    recipeList.forEach((Recipe) {
      print(Recipe.applabel);
      print(Recipe.appcalories);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yemek Tarifleri Sayfası'),
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
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if ((searchController.text).replaceAll(" ", "") == "") {
                    print("Blank search");
                  } else {
                    getRecipes(searchController.text);
                  }
                },
                child: Text('Tarifleri Ara'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
