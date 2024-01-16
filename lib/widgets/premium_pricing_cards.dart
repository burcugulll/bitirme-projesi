// ignore_for_file: unnecessary_string_escapes

import 'dart:convert';

import 'package:bitirme_projesi/services/firebase_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  final user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    super.initState();
  }

  Map<String, dynamic>? paymentIntentData;
  String secret =
      "sk_test_51OObjIG1UN1fHjhpHHrTVhvvSE71AaLHlu6WDRpbKqA6hwGbzGJpmaeizcbNyZVJbEedvJRLcvFrsj9pgHIihbEy00dFzIO1q5";
  bool isYearlyPlan = false;
  Future<void> makePayment(String value) async {
    try {
      paymentIntentData = await createPaymentIntent(value, 'TRY');

      var gpay = const PaymentSheetGooglePay(
          merchantCountryCode: "TR",
          currencyCode: "TRY",
          testEnv: true); // 'TR' ve 'TRY' olarak değiştirildi

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: paymentIntentData!['client_secret'],
            customFlow: true,
            style: ThemeMode.dark,
            merchantDisplayName: 'Beraat',
            googlePay: gpay),
      );

      displayPaymentSheet();
    } catch (e, s) {
      print('Ödeme hatası: $e $s');
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      print("Ödeme Tamamlandı");
      FirebaseServices firebase = FirebaseServices();
      final existingUser =
          await firebase.users.where("email", isEqualTo: user?.email).get();
      await existingUser.docs.first.reference.update({'plan': "premium"});

      showDialog(
          context: context,
          builder: (_) => const AlertDialog(
                content: Text("Ödeme Başarıyla Tamamlandı."),
              ));
    } on StripeException catch (e) {
      print('DISPLAYPAYMENTSHEET==> $e');
      showDialog(
          context: context,
          builder: (_) => const AlertDialog(
                content: Text("Ödeme İptal Edildi."),
              ));
    } catch (e) {
      print('DISPLAYPAYMENTSHEET==> $e');
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card',
      };
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization': 'Bearer ' + secret,
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      return jsonDecode(response.body);
    } catch (err) {
      print('createPaymentIntent err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
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
                price: '30₺',
                subPriceText: '\/ay',
                billedText: 'Aylık faturalandırılır',
                onPress: () {
                  makePayment('30');
                },
                cardColor: Colors.green,
                priceStyle: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                titleStyle: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
                billedTextStyle: const TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                ),
                subPriceStyle: const TextStyle(
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
                price: '300₺',
                subPriceText: '\/yıl',
                billedText: 'Yıllık faturalandırılır',
                onPress: () {
                  makePayment('300');
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
    );
  }
}
