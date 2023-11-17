import 'dart:io';

import 'package:bitirme_projesi/widgets/profile-image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilPage extends StatefulWidget {
  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  File? _selectedImage;

  Future<void> _pickImage() async {
    try {
      final picker = ImagePicker();
      final pickedImage = await picker.pickImage(source: ImageSource.gallery);

      if (pickedImage != null) {
        setState(() {
          _selectedImage = File(pickedImage.path);
        });

        final imagePath = pickedImage.path;
        final storageRef = FirebaseStorage.instance.ref();
        final fileName = DateTime.now()
            .millisecondsSinceEpoch
            .toString(); // Unique filename based on timestamp
        final imageRef = storageRef.child('images/$fileName.jpg');

        await imageRef.putFile(File(imagePath));

        // Get the download URL for the uploaded image
        final String downloadURL = await imageRef.getDownloadURL();
        print('Download URL: $downloadURL');
      }
    } catch (e) {
      print('Image picking error: $e');
      // Handle error (e.g., show a snackbar or alert dialog to the user)
    }
  }

  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white70,
        title: Text('Profil Sayfası'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ProfileImage(
              image: _selectedImage,
              onTap: _pickImage,
            ),
            SizedBox(height: 20),
            Text(
              'Giriş Yaptığınız E-Posta: ${user?.email ?? "Giriş yapılmamış"}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Hesap Türü: ${user?.isAnonymous == true ? "Premium" : "Ücretsiz"}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _showInformationDialog(context, 'Kilo Sayfası',
                    'Kilo bilgileriniz burada gösterilecek.');
              },
              child: Text('Kilom'),
            ),
            ElevatedButton(
              onPressed: () {
                // Boy sayfasına yönlendirme veya işlev ekleyin.
                _showInformationDialog(context, 'Boy Sayfası',
                    'Boy bilgileriniz burada gösterilecek.');
              },
              child: Text('Boyum'),
            ),
            ElevatedButton(
              onPressed: () {
                // Hatırlatıcılar sayfasına yönlendirme veya işlev ekleyin.
                _showInformationDialog(context, 'Hatırlatıcılar Sayfası',
                    'Hatırlatıcılarınız burada gösterilecek.');
              },
              child: Text('Hatırlatıcılar'),
            ),
            ElevatedButton(
              onPressed: () {
                // İletişim sayfasına yönlendirme veya işlev ekleyin.
                _showInformationDialog(context, 'İletişim Sayfası',
                    'İletişim bilgileriniz burada gösterilecek.');
              },
              child: Text('İletişim'),
            ),
            ElevatedButton(
              onPressed: () {
                // Gizlilik sayfasına yönlendirme veya işlev ekleyin.
                _showInformationDialog(context, 'Gizlilik Sayfası',
                    'Gizlilik bilgileriniz burada gösterilecek.');
              },
              child: Text('Gizlilik'),
            ),
            ElevatedButton(
              onPressed: () {
                // Bize Ulaşın sayfasına yönlendirme veya işlev ekleyin.
                _showInformationDialog(context, 'Bize Ulaşın Sayfası',
                    'Bize ulaşma bilgileriniz burada gösterilecek.');
              },
              child: Text('Bize Ulaşın'),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }

  void _showInformationDialog(
      BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Kapat'),
            ),
          ],
        );
      },
    );
  }
}
