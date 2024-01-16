import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

void main() {
  Stripe.publishableKey =
      "pk_test_51OObjIG1UN1fHjhpVTeopopu7Pp1Vgy8JoIAISlogxKjLKDWXVJ5xfFi7jw4ZdF2XE2QViiaUCENL067m4d8SClZ002EKooeRk";
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter demo home page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Map<String, dynamic>? paymentIntent;

  void makePayment() async {
    try {
      paymentIntent = await createPaymentIntent();
      var gpay = const PaymentSheetGooglePay(
        merchantCountryCode: "US",
        currencyCode: "US",
        testEnv: true,
      );

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent![
              "sk_test_51OObjIG1UN1fHjhpHHrTVhvvSE71AaLHlu6WDRpbKqA6hwGbzGJpmaeizcbNyZVJbEedvJRLcvFrsj9pgHIihbEy00dFzIO1q5"],
          style: ThemeMode.light,
          merchantDisplayName: "Sabir",
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
        "amount": "1000",
        "currency": "USD",
      };

      http.Response response = await http.post(
        Uri.parse("https://api.stripe.com/v1/payment_intents"),
        body: body,
        headers: {
          "Authorization":
              "Bearer sk_test_51OObjIG1UN1fHjhpHHrTVhvvSE71AaLHlu6WDRpbKqA6hwGbzGJpmaeizcbNyZVJbEedvJRLcvFrsj9pgHIihbEy00dFzIO1q5",
          "Content-Type": "application/x-www-form-urlencoded",
        },
      );

      return json.decode(response.body);
    } catch (e) {
      throw Exception("Ödeme isteği oluşturulurken hata: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Stripe Örneği"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            makePayment();
          },
          child: const Text("Ödemeyi Yap"),
        ),
      ),
    );
  }
}
