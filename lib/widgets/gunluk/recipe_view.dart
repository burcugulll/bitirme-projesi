// ignore_for_file: file_names, non_constant_identifier_names, must_be_immutable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RecipeView extends StatefulWidget {
  String url;
  RecipeView(this.url, {super.key});
  //const RecipeView({super.key});

  @override
  State<RecipeView> createState() => _RecipeViewState();
}

class _RecipeViewState extends State<RecipeView> {
  late String finalUrl;
  final Completer<WebViewController> controller =
      Completer<WebViewController>();
  @override
  void initState() {
    super.initState();
    if (widget.url.toString().contains("http://")) {
      finalUrl = widget.url.toString().replaceAll("http://", "https://");
    } else {
      finalUrl = widget.url;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Food Recipe App'),
      ),
      body: Container(
        child: WebView(
          initialUrl: finalUrl,
          javascriptmode: JavaScriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            setState(() {
              controller.complete(webViewController);
            });
          },
          onWebResourceError: (WebResourceError error) {
            // Hata ile ilgili gerekli işlemleri burada gerçekleştirebilirsiniz.
          },
        ),
      ),
    );
  }

  WebView(
      {required String initialUrl,
      required JavaScriptMode javascriptmode,
      required Null Function(WebViewController webViewController)
          onWebViewCreated,
      required Null Function(WebResourceError error) onWebResourceError}) {}
}
