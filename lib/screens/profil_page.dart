import 'dart:io';

import 'package:bitirme_projesi/screens/alarmlar.dart';
import 'package:bitirme_projesi/services/firebase_services.dart';
import 'package:bitirme_projesi/widgets/profile_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  double? _startingWeight;
  double? _currentWeight;
  double? _targetWeight;
  double? _height;
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
        final FirebaseServices firebase = FirebaseServices();

        final QuerySnapshot existingUser =
            await firebase.users.where("email", isEqualTo: user?.email).get();

        await existingUser.docs.first.reference
            .update({'imageUrl': downloadURL});

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
              imageUrl: user?.photoURL,
              onTap: _pickImage,
            ),
            SizedBox(height: 20),
            Text(
              'Giriş Yaptığınız E-Posta: ${user?.email ?? "Giriş yapılmamış"}',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              'Hesap Türü: ${user?.isAnonymous == true ? "Premium" : "Ücretsiz"}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                _showWeightInputDialog(context);
              },
              icon: Icon(Icons.monitor_weight),
              label: Text('Kilom'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                _showHeightInputDialog(context);
              },
              icon: Icon(Icons.height),
              label: Text('Boyum'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AlarmListWidget(),
                  ),
                );
              },
              icon: Icon(Icons.alarm),
              label: Text('Hatırlatıcılar'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                _showInformationDialog(context, 'İletişim ve Gizlilik Sayfası',
                    'Veri Onayı ve Kullanıcı Sözleşmesine Hoş geldiniz! Fitness ve Sağlık Uygulamasını kullanmaya başlamadan önce, aşağıdaki metni dikkatlice okumanız ve onaylamanız önemlidir.1. Toplanan Veriler: Uygulama, kullanıcılarına en iyi hizmeti sunabilmek için aşağıdaki verileri toplayabilir: Ad ve Soyad E-posta adresi Sağlık verileri Egzersiz alışkanlıkları 2. Veri Güvenliği ve Gizliliği: Fitness ve Sağlık Uygulaması,topladığı verileri güvenli bir şekilde saklamak ve üçüncü taraflarla paylaşmamak için gerekli teknik önlemleri alır. 3. Kullanıcı Hakları: Kullanıcılar, toplanan verileri görüntüleme, düzeltme ve silme haklarına sahiptir. 4. Onay ve Kabul: Fitness ve Sağlık Uygulamasını kullanarak, bu KVKK metnini okuduğunuzu, anladığınızı ve kabul ettiğinizi beyan edersiniz.');
              },
              icon: Icon(Icons.mail),
              label: Text('İletişim ve Gizlilik'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                _showInformationDialog(context, 'Bize Ulaşın',
                    "Sorularınız için burcugul10@gmail.com adresine mail atabilirsiniz");
              },
              icon: Icon(Icons.assistant_direction),
              label: Text('Bize Ulaşın'),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }

  void _showWeightInputDialog(BuildContext context) {
    TextEditingController startingWeightController = TextEditingController();
    TextEditingController currentWeightController = TextEditingController();
    TextEditingController targetWeightController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Kilo Bilgileri'),
          content: Column(
            children: [
              TextField(
                controller: startingWeightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Başlangıç Ağırlığı'),
              ),
              TextField(
                controller: currentWeightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Mevcut Ağırlık'),
              ),
              TextField(
                controller: targetWeightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Hedef Ağırlık'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('İptal'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _startingWeight =
                      double.tryParse(startingWeightController.text);
                  _currentWeight =
                      double.tryParse(currentWeightController.text);
                  _targetWeight = double.tryParse(targetWeightController.text);
                });
                Navigator.of(context).pop();
              },
              child: Text('Kaydet'),
            ),
          ],
        );
      },
    );
  }

  void _showHeightInputDialog(BuildContext context) {
    TextEditingController heightController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Boy Bilgisi'),
          content: Column(
            children: [
              TextField(
                controller: heightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Boy (cm)'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('İptal'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _height = double.tryParse(heightController.text);
                });
                Navigator.of(context).pop();
              },
              child: Text('Kaydet'),
            ),
          ],
        );
      },
    );
  }

  void _showInformationDialog(
      BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Column(
            children: [Text(content)],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
