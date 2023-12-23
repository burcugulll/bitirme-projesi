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

  Map<String, dynamic>? paymentIntentData;
  String secret =
      "sk_test_51OObjIG1UN1fHjhpHHrTVhvvSE71AaLHlu6WDRpbKqA6hwGbzGJpmaeizcbNyZVJbEedvJRLcvFrsj9pgHIihbEy00dFzIO1q5";

  Future<void> makePayment() async {
    try {
      paymentIntentData = await createPaymentIntent('37', 'USD');

      var gpay = const PaymentSheetGooglePay(
          merchantCountryCode: "US", currencyCode: "US", testEnv: true);

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
      print('Payment exception: $e $s');
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      print("Ödeme Tamamlandı");
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
