import 'package:webview_flutter/webview_flutter.dart';

class WebViewService {
  late final WebViewController controller;

  WebViewController initController({
    required String initialUrl,
    void Function(int progress)? onProgress,
    void Function(String url)? onPageStarted,
    void Function(String url)? onPageFinished,
    void Function(WebResourceError error)? onWebResourceError,
  }) {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: onProgress,
          onPageStarted: onPageStarted,
          onPageFinished: onPageFinished,
          onWebResourceError: onWebResourceError,
        ),
      )
      ..loadRequest(Uri.parse(initialUrl));

    return controller;
  }

  Future<void> loadUrl(String url) async {
    await controller.loadRequest(Uri.parse(url));
  }

  Future<void> reload() async {
    await controller.reload();
  }

  Future<void> goBack() async {
    if (await controller.canGoBack()) {
      await controller.goBack();
    }
  }

  Future<void> goForward() async {
    if (await controller.canGoForward()) {
      await controller.goForward();
    }
  }

  Future<void> runJavaScript(String script) async {
    await controller.runJavaScript(script);
  }
}