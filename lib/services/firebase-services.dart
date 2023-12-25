import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseServices {
  final usersCol = FirebaseFirestore.instance.collection("users");
}
