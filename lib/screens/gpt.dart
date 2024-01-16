import 'dart:convert';

import 'package:bitirme_projesi/screens/gunluk/model.dart';
import 'package:bitirme_projesi/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class Gpt extends StatefulWidget {
  const Gpt({Key? key}) : super(key: key);

  @override
  State<Gpt> createState() => _GptState();
}

class _GptState extends State<Gpt> {
  late final TextEditingController promptController;
  String responseText = "";
  late ChatCompletion _responseModel;
  @override
  void initState() {
    promptController =
        TextEditingController(); // Burada promptController'ı başlatın
    super.initState();
  }

  completionFun() async {
    setState(() {
      responseText = "Yükleniyor...";
    });

    final res =
        await http.post(Uri.parse("https://api.openai.com/v1/chat/completion"),
            headers: {
              'Content-Type': "application/json",
              "Authorization":
                  "Bearer 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"
            },
            body: jsonEncode({
              "model": "gpt-3.5-turbo",
              "prompt": promptController.text,
              "max_tokens": 250,
              "temperature": 0,
              "top_p": 1
            }));

    setState(() {
      _responseModel = ChatCompletion.fromJson(jsonDecode(res.body));
      responseText = _responseModel.choices[0].message.content;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff343541),
      appBar: AppBar(
        title: const Text(
          "ChatGpt",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xff343541),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: promptController,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: 'Bir şeyler yazın...',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: completionFun,
              child: Text('GPT ile Sohbet Et'),
            ),
          ),
        ],
      ),
    );
  }
}
