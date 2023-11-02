import "package:bitirme_projesi/screens/goal-selection-page.dart";
import "package:flutter/material.dart";
import "package:bitirme_projesi/screens/personel-info-page.dart";

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fitness ve Sağlık Uygulaması'),
        backgroundColor:
            Colors.deepPurple, // AppBar'ın arka plan rengini beyaz yapar
        foregroundColor: Colors.white70,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: 'Kullanıcı Adı',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Şifre',
                ),
                obscureText: true,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Kullanıcı adı ve şifre doğrulamasını burada yapabilirsiniz.
                // Ardından kişisel bilgi sayfasına yönlendirebilirsiniz.
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GoalSelectionPage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.deepPurple[400], // Lila (mor) arka plan rengi
              ),
              child: Text('Giriş Yap'),
            ),
            ElevatedButton(
              onPressed: () {
                // Kayıt sayfasına yönlendirin
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PersonalInfoPage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.deepPurple[400], // Lila (mor) arka plan rengi
              ),
              child: Text('Kayıt Ol'),
            ),
          ],
        ),
      ),
    );
  }
}
