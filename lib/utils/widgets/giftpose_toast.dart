// lib/utils/widgets/custom_toast.dart
import 'package:flutter/material.dart';

class CustomToast {
  static void show({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 3),
    Color backgroundColor = Colors.green,
    Color textColor = Colors.white,
    IconData icon = Icons.check_circle,
  }) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + 16,
        left: 16,
        right: 16,
        child: Material(
          color: Colors.transparent,
          child: SafeArea(
            child: AnimatedToast(
              message: message,
              backgroundColor: backgroundColor,
              textColor: textColor,
              icon: icon,
              duration: duration,
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(duration, () {
      overlayEntry.remove();
    });
  }
}

class AnimatedToast extends StatefulWidget {
  final String message;
  final Color backgroundColor;
  final Color textColor;
  final IconData icon;
  final Duration duration;

  const AnimatedToast({
    super.key,
    required this.message,
    required this.backgroundColor,
    required this.textColor,
    required this.icon,
    required this.duration,
  });

  @override
  State<AnimatedToast> createState() => _AnimatedToastState();
}

class _AnimatedToastState extends State<AnimatedToast>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _offsetAnimation,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                widget.icon,
                color: widget.textColor,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                widget.message,
                style: TextStyle(
                  color: widget.textColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}