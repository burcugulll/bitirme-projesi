import 'package:bitirme_projesi/widgets/premium_pricing_cards.dart';
import 'package:flutter/material.dart';

class PremiumPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Premium"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white70,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(10.0),
              child: Text(
                "Premium'a Geçin ve Hedeflerinize Daha Kolay Ulaşın",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
            PremiumPricingCards(),
            Container(
              margin: EdgeInsets.all(10.0),
              width: double.infinity,
              height: 2.0,
              color: Colors.black,
            ),
            Container(
              margin: EdgeInsets.all(20.0),
              child: Text(
                "Premium Motivasyonunuzu Daha Uzun Sürdürmenize ve Hedeflerinize Yaklaşmanıza Yardımcı Olur ",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Image.asset('assets/images/saglikli-yiyecek.jpg'),
            Container(
              margin: EdgeInsets.all(20.0),
              child: Text(
                "Diyetisyen desteği ile beslenme planları",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Image.asset('assets/images/diyetisyen.jpg'),
            Container(
              margin: EdgeInsets.all(20.0),
              child: Text(
                "Farklı yeme stillerine yönelik besin açısından dengeli beslenme planları ile yeme kararlarınızı basitleştirin.",
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            Image.asset('assets/images/ogun-plani.jpg'),
            Container(
              margin: EdgeInsets.all(20.0),
              child: Text(
                "Özel öğün planlarınızı oluşturun ve programlayın!",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10.0),
              child: Text(
                "Zahmetsizce Günlüğünüze programlayabileceğiniz kişiselleştirilmiş haftalık beslenme planları oluşturarak önceden plan yapın.",
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            Image.asset('assets/images/mutfak.jpg'),
            Container(
              margin: EdgeInsets.all(10.0),
              child: Text(
                "Yemek tariflerini doğrudan günlüğünüze kaydedin",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10.0),
              child: Text(
                "Mevcut tüm yemek tariflerini sadece birkaç dokunuşla doğrudan günlüğünüze kaydedin böylece manuel giriş ve hesaplama ihtiyacınız kalmayacak",
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            Image.asset('assets/images/yemekfoto.jpg'),
            Container(
              margin: EdgeInsets.all(10.0),
              child: Text(
                "Öğünleri nasıl yediğinizi takip edin",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10.0),
              child: Text(
                "Ekstra 6 öğün türü oluşturun ve bunları yeme şeklinize uygun benzersiz etiketlerle özelleştirin",
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            Image.asset('assets/images/su.jpg'),
            Container(
              margin: EdgeInsets.all(10.0),
              child: Text(
                "Günlük su alımınızı takip edin",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10.0),
              child: Text(
                "Su alımınızı izleyin ve hidrasyon hedeflerinizi özelleştirin",
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10.0),
              width: double.infinity,
              height: 2.0,
              color: Colors.black,
            ),
            Container(
              margin: EdgeInsets.all(10.0),
              child: Text(
                "Premium ile Hedeflerinize Yaklaşın\nMilyonlarca girişi analiz ettikten sonra Premium üyelerin günlük rutinlerine premium özellikleri eklerken hedef kilolarına 3 kat daha fazla yaklaştıklarını ve iki kat daha uzun süre motive kaldıklarını bulduk",
                style:
                    TextStyle(fontSize: 18.0, color: Colors.deepPurpleAccent),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
