// lib/utils/widgets/toast_manager.dart
import 'package:flutter/material.dart';

class ToastManager {
  static final ToastManager _instance = ToastManager._internal();
  factory ToastManager() => _instance;
  ToastManager._internal();

  static OverlayEntry? _currentToast;

  void showToast({
    required BuildContext context,
    required String message,
    ToastType type = ToastType.success,
    Duration duration = const Duration(seconds: 3),
  }) {
    // Remove existing toast if any
    _currentToast?.remove();

    // Get color based on type
    final Color backgroundColor = _getBackgroundColor(type);
    final IconData icon = _getIcon(type);

    // Create overlay entry
    _currentToast = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + 16,
        left: 16,
        right: 16,
        child: Material(
          color: Colors.transparent,
          child: _ToastWidget(
            message: message,
            backgroundColor: backgroundColor,
            icon: icon,
            duration: duration,
            onDismiss: () {
              _currentToast?.remove();
              _currentToast = null;
            },
          ),
        ),
      ),
    );

    // Insert overlay
    Overlay.of(context).insert(_currentToast!);

    // Auto dismiss after duration
    Future.delayed(duration, () {
      _currentToast?.remove();
      _currentToast = null;
    });
  }

  Color _getBackgroundColor(ToastType type) {
    switch (type) {
      case ToastType.success:
        return Colors.green;
      case ToastType.error:
        return Colors.red;
      case ToastType.warning:
        return Colors.orange;
      case ToastType.info:
        return Colors.blue;
    }
  }

  IconData _getIcon(ToastType type) {
    switch (type) {
      case ToastType.success:
        return Icons.check_circle;
      case ToastType.error:
        return Icons.error;
      case ToastType.warning:
        return Icons.warning;
      case ToastType.info:
        return Icons.info;
    }
  }
}

enum ToastType { success, error, warning, info }

class _ToastWidget extends StatefulWidget {
  final String message;
  final Color backgroundColor;
  final IconData icon;
  final Duration duration;
  final VoidCallback onDismiss;

  const _ToastWidget({
    required this.message,
    required this.backgroundColor,
    required this.icon,
    required this.duration,
    required this.onDismiss,
  });

  @override
  State<_ToastWidget> createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<_ToastWidget>
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
        child: GestureDetector(
          onTap: widget.onDismiss,
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
                  color: Colors.white,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    widget.message,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}