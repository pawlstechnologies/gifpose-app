import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:giftpose/utils/localization_provider.dart';
import 'package:giftpose/utils/theme/giftpose_colors.dart';
import 'package:giftpose/utils/theme/giftpose_text_style.dart';
import 'package:giftpose/utils/widgets/giftpose_button.dart';
import 'package:giftpose/utils/widgets/spacing.dart';

class ComingSoonModal extends StatelessWidget {
  final String? title;
  final String? description;

  const ComingSoonModal({
    super.key,
    this.title,
    this.description,
  });

  static Future<void> show(
    BuildContext context, {
    String? title,
    String? description,
  }) {
    HapticFeedback.heavyImpact();
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => ComingSoonModal(
        title: title,
        description: description,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: isDark ? Colors.white24 : Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const YMargin(16),

          // Close Icon
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Icon(
                Icons.close,
                color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                size: 22,
              ),
            ),
          ),

          // Icon Container
          Container(
            height: 72,
            width: 72,
            decoration: BoxDecoration(
              color: GiftPoseColors.primaryColor.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                Icons.auto_awesome_rounded,
                size: 36,
                color: GiftPoseColors.primaryColor,
              ),
            ),
          ),
          const YMargin(20),

          // Title
          Text(
            (title ?? "Coming Soon!").tr(context),
            textAlign: TextAlign.center,
            style: GiftPoseTextStyle.medium(
              fontWeight: FontWeight.w700,
              fontSize: 20,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
          const YMargin(10),

          // Description
          Text(
            (description ??
                    "We're currently working on the change subscription feature. Stay tuned for upcoming updates!")
                .tr(context),
            textAlign: TextAlign.center,
            style: GiftPoseTextStyle.small(
              color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
              fontSize: 14,
            ),
          ),
          const YMargin(28),

          // Dismiss Button
          GiftPoseButton(
            title: "Got it".tr(context),
            onTap: () {
              HapticFeedback.heavyImpact();
              Navigator.pop(context);
            },
          ),
          const YMargin(12),
        ],
      ),
    );
  }
}
