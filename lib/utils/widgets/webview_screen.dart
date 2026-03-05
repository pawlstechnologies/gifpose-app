import 'package:flutter/material.dart';
import 'package:giftpose/utils/widgets/giftpose_webview.dart';


class WebViewScreen extends StatelessWidget {
  final String url;
  final String title;

  const WebViewScreen({
    super.key,
    required this.url,
    this.title = "Web View",
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: GiftPoseWebView(
        url: url,
      ),
    );
  }
}