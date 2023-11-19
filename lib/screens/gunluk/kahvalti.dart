import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

class _YemekTarifleriPageState extends State<YemekTarifleriPage> {
  TextEditingController _searchController = new TextEditingController();
  String _apiUrl =
      'https://api.edamam.com/search?q=chicken&app_id=9dbf4610&app_key=0e45552529bb0b4cb1d5c8232226f7ed';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yemek Tarifleri Sayfası'),
      ),
      body: Column(
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: _searchController,
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
                  _searchRecipes();
                },
                child: Text('Tarifleri Ara'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _searchRecipes() async {
    final response = await http.get(Uri.parse(_apiUrl));

    if (response.statusCode == 200) {
      // Başarılı bir şekilde veri alındı.
      // TODO: Burada API'den gelen verileri işleyin ve kullanın.
      print(response.body);
    } else {
      // API isteğinde bir hata oluştu.
      print('API isteğinde hata: ${response.statusCode}');
    }
  }
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
