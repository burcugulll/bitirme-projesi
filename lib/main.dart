import 'package:bitirme_projesi/screens/home_page.dart';
import 'package:bitirme_projesi/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:bitirme_projesi/screens/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:flutter_stripe/flutter_stripe.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Stripe.publishableKey =
      "pk_test_51OObjIG1UN1fHjhpVTeopopu7Pp1Vgy8JoIAISlogxKjLKDWXVJ5xfFi7jw4ZdF2XE2QViiaUCENL067m4d8SClZ002EKooeRk";

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //await dotenv.load(fileName: "../assets/.env");

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterChat',
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SplashScreen();
            }

            if (snapshot.hasData) {
              return MyHomePage();
            }
            return const AuthScreen();
          }),
    );
  }
}
