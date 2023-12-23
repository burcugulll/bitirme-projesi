import 'dart:convert';

import "package:flutter/material.dart";
import "package:pricing_cards/pricing_cards.dart";
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class PremiumPricingCards extends StatefulWidget {
  const PremiumPricingCards({super.key});
  @override
  State<PremiumPricingCards> createState() => _PremiumPricingCardsState();
}

class _PremiumPricingCardsState extends State<PremiumPricingCards> {
  @override
  void initState() {
    super.initState();
  }

  Map<String, dynamic>? paymentIntent;
  String secret =
      "sk_test_51OObjIG1UN1fHjhpHHrTVhvvSE71AaLHlu6WDRpbKqA6hwGbzGJpmaeizcbNyZVJbEedvJRLcvFrsj9pgHIihbEy00dFzIO1q5";
  void makePayment() async {
    try {
      paymentIntent = await createPaymentIntent();
      var gpay = const PaymentSheetGooglePay(
        merchantCountryCode: "TR",
        currencyCode: "TRY",
        testEnv: true,
      );

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent![secret],
          style: ThemeMode.light,
          merchantDisplayName: "Beraat",
          googlePay: gpay,
        ),
      );
    } catch (e) {
      print("Hata: $e");
    }
  }

  void displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      print("Ödeme Tamamlandı");
    } catch (e) {
      print("Ödeme Başarısız: $e");
    }
  }

  Future<Map<String, dynamic>> createPaymentIntent() async {
    try {
      Map<String, dynamic> body = {
        "amount": "39",
        "currency": "TRY",
      };

      http.Response response = await http.post(
        Uri.parse("https://api.stripe.com/v1/payment_intents"),
        body: body,
        headers: {
          "Authorization": "Bearer " + secret,
          "Content-Type": "application/x-www-form-urlencoded",
        },
      );

      return json.decode(response.body);
    } catch (e) {
      throw Exception("Ödeme isteği oluşturulurken hata: $e");
    }
  }

  Widget build(BuildContext context) {
    return Padding(
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
                  print("tıklandı");
                  makePayment();
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
                onPress: () {},
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
    );
  }
}
