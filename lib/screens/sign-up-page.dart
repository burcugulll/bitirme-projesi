import "package:bitirme_projesi/screens/personel-info-page.dart";
import "package:flutter/material.dart";

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kayıt Ol'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Kayıt olmak için gerekli giriş alanları ve düğmeleri ekleyin

            ElevatedButton(
              onPressed: () {
                // Kayıt işlemi burada gerçekleşebilir
                // Ardından PersonalInfoPage'ye yönlendirebilirsiniz
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PersonalInfoPage(),
                  ),
                );
              },
              child: const Text('Kayıt Ol'),
            ),
          ],
        ),
      ),
    );
  }
}
