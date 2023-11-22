import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart';

import 'package:bitirme_projesi/screens/gunluk/model.dart';
import 'package:url_launcher/url_launcher.dart';

class YemekTarifleriPage extends StatefulWidget {
  @override
  _YemekTarifleriPageState createState() => _YemekTarifleriPageState();
}

class _YemekTarifleriPageState extends State<YemekTarifleriPage> {
  List<RecipeModel> recipeList = <RecipeModel>[];
  TextEditingController searchController = TextEditingController();

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

          recipeList.forEach((Recipe) {
            print(Recipe.applabel);
            print(Recipe.appcalories);
          });
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

  @override
  void initState() {
    super.initState();
    getRecipes("cake");
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
                      //_launchURL(recipeList[index].appurl);
                      /*Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  RecipeView(recipeList[index].appurl)));
                    */
                      print(recipeList[index].appurl);
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
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.local_fire_department, size: 13),
                                Text(
                                  recipeList[index]
                                      .appcalories
                                      .toString()
                                      .substring(0, 6),
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
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
/* bu satırda web sitesine yönlendirme yapmaya çalışmıştım
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }*/
}
