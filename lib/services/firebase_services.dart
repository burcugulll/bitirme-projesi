import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseServices {
  final users = FirebaseFirestore.instance.collection("users");
}