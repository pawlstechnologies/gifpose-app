import 'package:flutter/material.dart';
import 'package:giftpose/services/network_services/webview_service.dart';
import 'package:webview_flutter/webview_flutter.dart';


class GiftPoseWebView extends StatefulWidget {
  final String url;
  final bool showLoader;

  const GiftPoseWebView({
    super.key,
    required this.url,
    this.showLoader = true,
  });

  @override
  State<GiftPoseWebView> createState() => _GiftPoseWebViewState();
}

class _GiftPoseWebViewState extends State<GiftPoseWebView> {
  final WebViewService _webViewService = WebViewService();
  late WebViewController _controller;

  bool _isLoading = true;
  int _progress = 0;

  @override
  void initState() {
    super.initState();

    _controller = _webViewService.initController(
      initialUrl: widget.url,
      onProgress: (progress) {
        setState(() {
          _progress = progress;
        });
      },
      onPageStarted: (_) {
        setState(() => _isLoading = true);
      },
      onPageFinished: (_) {
        setState(() => _isLoading = false);
      },
      onWebResourceError: (error) {
        debugPrint("WebView Error: ${error.description}");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WebViewWidget(controller: _controller),

        if (widget.showLoader && _isLoading)
          LinearProgressIndicator(
            value: _progress / 100,
          ),
      ],
    );
  }
}