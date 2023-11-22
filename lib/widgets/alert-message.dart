import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class AlertMessage extends StatelessWidget {
  final ToastificationType alertType;
  final String message;
  final BuildContext context;

  AlertMessage(
      {required this.alertType, required this.message, required this.context}) {
    _showAlert();
  }

  @override
  Widget build(BuildContext context) {
    return Container(); // Boş bir container dönebilirsiniz, çünkü bu widget ekranda görünmeyecek.
  }

  void _showAlert() {
    toastification.show(
        context: context,
        title: message,
        autoCloseDuration: const Duration(seconds: 3),
        type: alertType);
  }
}
