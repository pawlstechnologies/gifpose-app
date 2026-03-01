import 'package:flutter/material.dart';
import 'package:giftpose/utils/theme/giftpose_colors.dart';
import 'package:giftpose/utils/theme/theme.dart';


class MyBottomSheet {
  static void showDismissibleBottomSheet({
    required BuildContext context,
    required List<Widget> children,
    double? height,
    double? header,
    String? title,
    Widget? bottomAction,
  }) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        isScrollControlled: true,
        context: context,
        builder: (ctx) => Container(
              constraints: BoxConstraints(
                maxHeight: height ?? MediaQuery.of(context).size.height / 1.8,
              ),
              color: Theme.of(context).scaffoldBackgroundColor,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 5),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 5,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  title == null
                      ? const SizedBox.shrink()
                      : const SizedBox(
                          height: 25,
                        ),
                  title == null
                      ? const SizedBox.shrink()
                      : Align(
                          alignment: Alignment.center,
                          child: title.isEmpty
                              ? const SizedBox.shrink()
                              : Text(title ?? "",
                                  style: GiftPoseTextStyle.heading1())),
                  SizedBox(
                    height: header ?? 30,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: children),
                    ),
                  ),
                  bottomAction ?? const SizedBox.shrink(),
                  bottomAction == null
                      ? const SizedBox.shrink()
                      : const SizedBox(
                          height: 50,
                        ),
                ],
              ),
            ));
  }

  static void showNonDismissibleBottomSheet({
    required BuildContext context,
    required List<Widget> children,
    double? height,
  }) {
    showModalBottomSheet(
        isDismissible: false,
        enableDrag: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        isScrollControlled: true,
        context: context,
        builder: (ctx) => Container(
              constraints: BoxConstraints(
                maxHeight: height ?? MediaQuery.of(context).size.height / 1.8,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: children),
                    ),
                  ),
                ],
              ),
            ));
  }
}

class AnimatedBottomSheet extends StatefulWidget {
  const AnimatedBottomSheet({required this.screen, super.key});
  final Widget screen;
  @override
  AnimatedBottomSheetState createState() => AnimatedBottomSheetState();
}

class AnimatedBottomSheetState extends State<AnimatedBottomSheet>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500),);
    _animation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    return AnimatedBuilder(
        animation: _animationController,
        builder: (final context, final child) {
          return SlideTransition(
            position: _animation,
            child: child,
          );
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOut,
          child: widget.screen,
        ));
  }
}


class AppBottomSheet{
  dynamic setScreen(final Widget screen, final BuildContext context, final Color? backgroundColor) {
    showSheet(context: context, screen: screen, backgroundColor: backgroundColor);
  }


  Future<void> showSheet({required final BuildContext context, required final Widget screen, final Color? backgroundColor}) async {
    final AnimationController transitionAnimationController = AnimationController(
      animationBehavior: AnimationBehavior.preserve,
      vsync: Navigator.of(context),
      duration: const Duration(milliseconds: 800),
    );
    await showModalBottomSheet(
      transitionAnimationController: transitionAnimationController,
      isScrollControlled: true,
      showDragHandle: true,
      context: context,
      useRootNavigator: true,
      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
      backgroundColor:  Theme.of(context).scaffoldBackgroundColor,
      builder: (final BuildContext context) {
        return AnimatedBottomSheet(
          screen: screen,
        );
      },
    );
  }
}