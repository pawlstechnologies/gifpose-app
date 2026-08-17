import 'dart:async';

import 'package:flutter/material.dart';
import 'package:giftpose/utils/widgets/spacing.dart';

class LoaderPage extends StatefulWidget {
  final bool isDismissible;
  final Duration autoDismissDuration;

  LoaderPage({
    super.key,
    this.isDismissible = true,
    this.autoDismissDuration = const Duration(seconds: 10),
  });

  static BuildContext? _currentLoaderContext;
  static Timer? _autoDismissTimer;

  // Static method to show as full-screen dialog
  static Future<void> show(
    BuildContext context, {
    bool isDismissible = true,
    Duration autoDismissDuration = const Duration(seconds: 10),
  }) {
    dismiss();

    _autoDismissTimer = Timer(autoDismissDuration, () {
      dismiss();
    });

    return showDialog(
      context: context,
      barrierDismissible: isDismissible,
      barrierColor: Colors.black.withValues(alpha: 0.5), // Full screen overlay
      builder: (BuildContext dialogContext) {
        _currentLoaderContext = dialogContext;
        return PopScope(
          canPop: isDismissible,
          onPopInvokedWithResult: (didPop, result) {
            if (didPop) {
              _cancelTimer();
              _currentLoaderContext = null;
            }
          },
          child: LoaderPage(isDismissible: isDismissible),
        );
      },
    ).then((_) {
      _cancelTimer();
      _currentLoaderContext = null;
    });
  }

  static void _cancelTimer() {
    _autoDismissTimer?.cancel();
    _autoDismissTimer = null;
  }

  static void dismiss() {
    _cancelTimer();
    if (_currentLoaderContext != null && _currentLoaderContext!.mounted) {
      final ctx = _currentLoaderContext!;
      _currentLoaderContext = null;
      if (Navigator.canPop(ctx)) {
        Navigator.of(ctx, rootNavigator: true).pop();
      }
    }
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
    final isDarkMode =
        Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () {
        if (widget.isDismissible) {
          LoaderPage.dismiss();
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              isDarkMode
                  ? Image.asset(
                      "assets/images/dLoad.gif",
                      width: 340,
                      height: 280,
                    )
                  : Image.asset(
                      "assets/images/loader.gif",
                      width: 340,
                      height: 280,
                    ),
              YMargin(30),
            ],
          ),
        ),
      ),
    );
  }
}