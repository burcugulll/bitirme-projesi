import "package:flutter/material.dart";
import "package:bitirme_projesi/screens/home-page.dart";

class GoalSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hedef Seçimi'),
        backgroundColor:
            Colors.deepPurple, // AppBar'ın arka plan rengini beyaz yapar
        foregroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Lütfen ana hedefinizi seçin:',
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.deepPurple[400],
                fontWeight: FontWeight.bold,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Kilo vermek seçeneği seçildiğinde yapılacak işlemleri burada tanımlayabilirsiniz.
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyHomePage(), // Yönlendirilecek sayfa
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.deepPurple[300],
              ),
              child: Text('Kilo vermek'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage()),
                );
                // Kilo korumak seçeneği seçildiğinde yapılacak işlemleri burada tanımlayabilirsiniz.
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.deepPurple[300],
              ),
              child: Text('Kilomu korumak'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage()),
                );
                // Kilo almak seçeneği seçildiğinde yapılacak işlemleri burada tanımlayabilirsiniz.
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.deepPurple[300],
              ),
              child: Text('Kilo almak'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage()),
                );
                // Kas yapmak seçeneği seçildiğinde yapılacak işlemleri burada tanımlayabilirsiniz.
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.deepPurple[300],
              ),
              child: Text('Kas yapmak'),
            ),
          ],
        ),
      ),
    );
  }
}
