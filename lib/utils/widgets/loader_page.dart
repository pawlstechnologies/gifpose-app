import 'dart:async';
import 'package:flutter/material.dart';
import 'package:giftpose/gen/assets.gen.dart';
import 'package:giftpose/utils/router/utils.dart';
import 'package:giftpose/utils/theme/theme.dart';
import 'package:giftpose/utils/widgets/spacing.dart';

class LoaderPage extends StatefulWidget {
  const LoaderPage({super.key});

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

    // Auto dismiss after 3 seconds
    Timer(const Duration(seconds:2 ), () {
      if (mounted) {
        // Navigator.of(context).pop(); 
                 HapticFeedback.selectionClick();
              Navigator.pushReplacementNamed(context,  AppRoutes.dashboard);
        // or Navigator.pushReplacement(...)
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            backgroundColor:  Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RotationTransition(
              turns: _controller,
              child:Image.asset("assets/images/loader.png")
            ),
            YMargin(30),
             Text(
              "Getting Gifts Closer to you..........",
            style: GiftPoseTextStyle.medium(fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}