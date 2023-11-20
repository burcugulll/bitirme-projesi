import 'dart:convert';
import 'dart:developer';
import 'package:bitirme_projesi/screens/gunluk/ogle.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:bitirme_projesi/screens/gunluk/model.dart';

Widget MyText() {
  return Text("my text widget is here");
}

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

class KahvaltiPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white70,
        title: Text('Kahvaltı Sayfası'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    // Yemek sayfasına yönlendirme
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => YemekPage()),
                    );
                  },
                  child: Text(
                    'Yemek',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Yemek Tarifleri sayfasına yönlendirme
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => YemekTarifleriPage()),
                    );
                  },
                  child: Text(
                    'Yemek Tarifleri',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Kaydedilen Öğünler sayfasına yönlendirme
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
          ),
          // Diğer sayfa içerikleri buraya eklenebilir.
        ],
      ),
    );
  }
}

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

class YemekTarifleriPage extends StatefulWidget {
  @override
  _YemekTarifleriPageState createState() => _YemekTarifleriPageState();
}

/*
class _YemekTarifleriPageState extends State<YemekTarifleriPage> {
  //List<RecipeModel> recipeList = <RecipeModel>[];
  TextEditingController searchController = new TextEditingController();
  List reciptCatList = [
    {
      "imgUrl": "https://images.unsplash.com/photo-1593560704563-f176a2eb61db",
      "heading": "Chilli Food"
    },
    {
      "imgUrl": "https://images.unsplash.com/photo-1593560704563-f176a2eb61db",
      "heading": "Chilli Food"
    },
    {
      "imgUrl": "https://images.unsplash.com/photo-1593560704563-f176a2eb61db",
      "heading": "Chilli Food"
    },
    {
      "imgUrl": "https://images.unsplash.com/photo-1593560704563-f176a2eb61db",
      "heading": "Chilli Food"
    }
  ];

  getRecipes(String query) async {
    String url =
        'https://api.edamam.com/search?q=$query&app_id=9dbf4610&app_key=0e45552529bb0b4cb1d5c8232226f7ed';
    Response response = await get(Uri.parse(url));
    Map data = jsonDecode(response.body);
    //log(data.toString());
    //print(data);

/*
    data["hits"].forEach((element) {
      RecipeModel recipeModel = new RecipeModel();
      recipeModel = RecipeModel.fromMap(element["recipe"]);
      recipeList.add(recipeModel);
      log(recipeList.toString());
    });

    recipeList.forEach((Recipe) {
      print(Recipe.applabel);
      print(Recipe.appcalories);
    });
    */
  }

  @override
  void initState() {
    super.initState();
    //getRecipes("Ladoo");
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
            Container(
              padding: EdgeInsets.all(16),
              child: Text(
                'Bugün ne pişirmek istersin?',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
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
                    onTap: () {},
                    child: Card(
                      margin: EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.6),
                      ),
                      elevation: 0.0,
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.network(
                              recipeList[index].appimgUrl,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 200,
                            ),
                          ),
                          Positioned(
                            left: 0,
                            right: 0,
                            bottom: 0,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 10,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black54,
                              ),
                              child: Text(
                                recipeList[index].applabel,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                ),
                              ),
                              height: 50,
                              width: 100,
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.local_fire_department),
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
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            
            Container(
              height: 100,
              child: ListView.builder(
                itemCount: reciptCatList.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    child: InkWell(
                      onTap: () {},
                      child: Card(
                        margin: EdgeInsets.all(20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        elevation: 0.0,
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(18.0),
                              child: Image.network(
                                reciptCatList[index]["imgUrl"],
                                fit: BoxFit.cover,
                                width: 200,
                                height: 250,
                              ),
                            ),
                            Positioned(
                              left: 0,
                              right: 0,
                              bottom: 0,
                              top: 0,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: 5,
                                  horizontal: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.black26,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      reciptCatList[index]["heading"],
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 28,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            
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
            Expanded(
              child: Center(
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
            ),
          ],
        ),
      ),
    );
  }
}
*/
class _YemekTarifleriPageState extends State<YemekTarifleriPage> {
  List<RecipeModel> recipeList = <RecipeModel>[];
  TextEditingController searchController = TextEditingController();
  List reciptCatList = [
    {
      "imgUrl": "https://images.unsplash.com/photo-1593560704563-f176a2eb61db",
      "heading": "Chilli Food"
    },
    {
      "imgUrl": "https://images.unsplash.com/photo-1593560704563-f176a2eb61db",
      "heading": "Chilli Food"
    },
    {
      "imgUrl": "https://images.unsplash.com/photo-1593560704563-f176a2eb61db",
      "heading": "Chilli Food"
    },
    {
      "imgUrl": "https://images.unsplash.com/photo-1593560704563-f176a2eb61db",
      "heading": "Chilli Food"
    }
  ];

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
            Container(
              padding: EdgeInsets.all(16),
              child: Text(
                'Bugün ne pişirmek istersin?',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              height: 100,
              child: ListView.builder(
                itemCount: reciptCatList.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    child: InkWell(
                      onTap: () {},
                      child: Card(
                        margin: EdgeInsets.all(20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        elevation: 0.0,
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(18.0),
                              child: Image.network(
                                reciptCatList[index]["imgUrl"],
                                fit: BoxFit.cover,
                                width: 200,
                                height: 250,
                              ),
                            ),
                            Positioned(
                              left: 0,
                              right: 0,
                              bottom: 0,
                              top: 0,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: 5,
                                  horizontal: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.black26,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      reciptCatList[index]["heading"],
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 28,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
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
