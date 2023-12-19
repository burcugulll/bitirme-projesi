import 'package:flutter/material.dart';
import 'package:bitirme_projesi/screens/odeme.dart';
import 'package:pricing_cards/pricing_cards.dart';

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
            Padding(
              padding: EdgeInsets.symmetric(vertical: 28),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PricingCards(
                    pricingCards: [
                      PricingCard(
                        title: 'Aylık',
                        price: '35.99₺',
                        subPriceText: '\/ay',
                        billedText: 'Aylık faturalandırılır',
                        onPress: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MyApp()),
                          );
                        },
                        cardColor: Colors.green,
                        priceStyle: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        titleStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                        billedTextStyle: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                        subPriceStyle: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                        cardBorder: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.red, width: 4.0),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      PricingCard(
                        title: 'Yıllık',
                        price: '299.99₺',
                        subPriceText: '\/yıl',
                        billedText: 'Yıllık faturalandırılır',
                        onPress: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MyApp()),
                          );
                        },
                        cardColor: Colors.deepOrangeAccent,
                        priceStyle: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        titleStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                        billedTextStyle: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                        subPriceStyle: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                        cardBorder: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.red, width: 4.0),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
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
            Image.asset('assets/images/ayniyemekler.jpg'),
            Container(
              margin: EdgeInsets.all(10.0),
              child: Text(
                "Daha hızlı yemek kaydi için yiyecekleri birden çok güne kopyalayın",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10.0),
              child: Text(
                "Düzenli olarak yenen yiyecekleri birden çok öğüne ve güne kopyalayarak zamandan tasarruf edin",
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
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
