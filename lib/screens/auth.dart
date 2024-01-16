import 'dart:async';

import 'package:bitirme_projesi/services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final _firebase = FirebaseAuth.instance;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _form = GlobalKey<FormState>();
  var _isLogin = true;
  var _enteredEmail = '';
  var _enteredPassword = '';

  void _submit() async {
    final isValid = _form.currentState!.validate();

    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    try {
      if (_isLogin) {
        await _firebase.signInWithEmailAndPassword(
            email: _enteredEmail, password: _enteredPassword);
        //print(userCredentials);
      } else {
        await _firebase.createUserWithEmailAndPassword(
            email: _enteredEmail, password: _enteredPassword);
        //print(userCredentials);
      }

      final user = await FirebaseAuth.instance.currentUser;
      final FirebaseServices firebase = FirebaseServices();

      final existingUser =
          await firebase.users.where("email", isEqualTo: user?.email).get();

      if (existingUser.docs.isEmpty) {
        await firebase.users.add({
          'email': user?.email,
          'name': user?.displayName,
          'imageUrl': user?.photoURL,
          'plan': "normal"
        });
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == 'email-already-in-use') {}

      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Email veya şifre hatalı."),
        ),
      );
    }
  }

  Future _authWithGoogle() async {
    try {
      await GoogleSignIn().signOut();
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        print("Google ile giriş iptal edildi.");
        return; // Google ile giriş iptal edildiyse işlemi sonlandır
      }

      final GoogleSignInAuthentication? googleAuth =
          await googleUser.authentication;

      if (googleAuth == null) {
        print("Google authentication bilgisi alınamadı.");
        return; // Google authentication bilgisi alınamadıysa işlemi sonlandır
      }

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential user =
          await FirebaseAuth.instance.signInWithCredential(credential);

      print(user.user?.displayName);
      final FirebaseServices firebase = FirebaseServices();

      final existingUser = await firebase.users
          .where("email", isEqualTo: user.user?.email)
          .get();

      if (existingUser.docs.isEmpty) {
        // If user doesn't exist, create a new user record in Firestore
        await firebase.users.add({
          'email': user.user?.email,
          'name': user.user?.displayName,
          'imageUrl': user.user?.photoURL,

          // Add other fields as needed
        });
      }
    } catch (error, stackTrace) {
      print("Google ile girişte bir hata oluştu: $error");
      print("Hata izi: $stackTrace");

      // Hata mesajını kullanıcıya göstermek icin
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              "Google ile girişte bir hata oluştu. Lütfen tekrar deneyin."),
        ),
      );
    } finally {
      print("Try-catch bloğu tamamlandı.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: 30,
                  bottom: 20,
                  left: 20,
                  right: 20,
                ),
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('assets/images/anasayfa.jpg'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Card(
                margin: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: _form,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(_isLogin ? "Giriş Ekranı" : "Kayıt Ekranı",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w800)),
                          TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'Email Address'),
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            validator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty ||
                                  !value.contains('@')) {
                                return 'Please enter a valid email adress';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _enteredEmail = value!;
                            },
                          ),
                          TextFormField(
                            decoration:
                                const InputDecoration(labelText: 'Password'),
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.trim().length < 6) {
                                return 'Password must be at least 6 characters long ';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _enteredPassword = value!;
                            },
                          ),
                          const SizedBox(height: 12),
                          Container(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _submit,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              child: Text(_isLogin ? 'Giriş Yap' : 'Kayıt Ol'),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: _authWithGoogle,
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                onPrimary: Colors.black,
                                side:
                                    BorderSide(color: Colors.black, width: .3),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              icon: Icon(
                                Icons.account_circle,
                                size: 28.0,
                                color: Colors.deepPurple,
                              ),
                              label: Text(
                                _isLogin
                                    ? 'Google ile Giriş Yap'
                                    : 'Google ile Kayıt Ol',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _isLogin = !_isLogin;
                              });
                            },
                            child: Text(_isLogin
                                ? 'Yeni Bir Hesap Oluştur'
                                : 'Hesabınız Varsa Giriş Yapın'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
