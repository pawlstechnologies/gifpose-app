import 'dart:async';
import 'package:giftpose/utils/localization_provider.dart';

import 'package:flutter/material.dart';

import 'package:giftpose/gen/assets.gen.dart';
import 'package:giftpose/utils/theme/theme.dart';
import 'package:giftpose/utils/widgets/spacing.dart';

class LoaderPage extends StatefulWidget {
  LoaderPage({super.key});

  // Static method to show as full-screen dialog
  static Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black, // Full screen overlay
      builder: (BuildContext context) {
        return PopScope(
          canPop: false,
          child: LoaderPage(),
        );
      },
    );
  }

  @override
  State<LoaderPage> createState() => _LoaderPageState();
}

class _LoaderPageState extends State<LoaderPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    // Spin animation
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              "assets/images/loader.gif",
              width: 340,
              height: 280,
            ),
            YMargin(30),
            Text("Getting Gifts Closer to you...".tr(context),
              style: GiftPoseTextStyle.medium(fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}