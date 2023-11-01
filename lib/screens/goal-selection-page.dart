import "package:flutter/material.dart";

class GoalSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hedef Seçimi'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Lütfen ana hedefinizi seçin:',
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.indigo,
                fontWeight: FontWeight.bold,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Kilo vermek seçeneği seçildiğinde yapılacak işlemleri burada tanımlayabilirsiniz.
              },
              child: Text('Kilo Vermek'),
            ),
            ElevatedButton(
              onPressed: () {
                // Kilo korumak seçeneği seçildiğinde yapılacak işlemleri burada tanımlayabilirsiniz.
              },
              child: Text('Kilomu korumak'),
            ),
            ElevatedButton(
              onPressed: () {
                // Kilo almak seçeneği seçildiğinde yapılacak işlemleri burada tanımlayabilirsiniz.
              },
              child: Text('Kilo almak'),
            ),
            ElevatedButton(
              onPressed: () {
                // Kas yapmak seçeneği seçildiğinde yapılacak işlemleri burada tanımlayabilirsiniz.
              },
              child: Text('Kas yapmak'),
            ),
          ],
        ),
      ),
    );
  }
}
