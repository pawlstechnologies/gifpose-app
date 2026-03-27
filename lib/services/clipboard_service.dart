import 'package:flutter/services.dart';
import 'package:giftpose/utils/localization_provider.dart';

import 'package:flutter/material.dart';

Future<void> copyToClipboard(BuildContext context, String text) async {
  await Clipboard.setData(ClipboardData(text: text));

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text("Copied to clipboard".tr(context)),
      duration: Duration(seconds: 2),
    ),
  );
}