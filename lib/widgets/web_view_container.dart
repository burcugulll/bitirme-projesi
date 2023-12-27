import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewContainer extends StatefulWidget {
  final String url;
  final String recipe;

  WebViewContainer({required this.url, required this.recipe});

  @override
  State<WebViewContainer> createState() => _WebViewContainerState();
}

class _WebViewContainerState extends State<WebViewContainer> {
  late WebViewController controller;

  @override
  void initState() {
    super.initState();

    // initState içinde controller'ı oluşturun ve URL'yi yükleyin
    controller = WebViewController();
    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.recipe)),
      body: WebViewWidget(controller: controller),
    );
  }
}
