import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

Future<void> copyToClipboard(BuildContext context, String text) async {
  await Clipboard.setData(ClipboardData(text: text));

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text("Copied to clipboard"),
      duration: Duration(seconds: 2),
    ),
  );
}