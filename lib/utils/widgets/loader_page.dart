import 'dart:async';
import 'package:flutter/material.dart';

import 'package:giftpose/gen/assets.gen.dart';
import 'package:giftpose/utils/theme/theme.dart';
import 'package:giftpose/utils/widgets/spacing.dart';

class LoaderPage extends StatefulWidget {
  const LoaderPage({super.key});

  // Static method to show as full-screen dialog
  static Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black, // Full screen overlay
      builder: (BuildContext context) {
        return const PopScope(
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
      duration: const Duration(seconds: 2),
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
            RotationTransition(
              turns: _controller,
              child: Image.asset(
                "assets/images/loader.png",
                width: 80,
                height: 80,
              ),
            ),
            const YMargin(30),
            Text(
              "Getting Gifts Closer to you...",
              style: GiftPoseTextStyle.medium(fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}