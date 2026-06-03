import 'package:flutter/material.dart';
import 'package:giftpose/utils/localization_provider.dart';
import 'package:giftpose/utils/theme/giftpose_text_style.dart';
import 'package:giftpose/utils/widgets/giftpose_button.dart';
import 'package:giftpose/utils/widgets/spacing.dart';

class PremiumFeaturesModal extends StatelessWidget {
  const PremiumFeaturesModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Close Icon and Rocket Header
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.close, color: Colors.grey),
            ),
          ),
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              color: const Color(0xFFF0EFFF), // Light purple background
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Center(
              child: Icon(
                Icons.rocket_launch_rounded,
                size: 40,
                color: Color(0xFF5D5FEF), // Rocket color
              ),
            ),
          ),
          const YMargin(20),
          
          // Title
          Text(
            "Unlock Premium Features!".tr(context),
            style: GiftPoseTextStyle.medium(
              fontWeight: FontWeight.w700,
              fontSize: 22,
            ),
          ),
          const YMargin(12),
          
          // Subtitle
          Text(
            "To add more than three(3) keywords, go premium now and unlock premium features!".tr(context),
            textAlign: TextAlign.center,
            style: GiftPoseTextStyle.small(
              color: Colors.blueGrey,
              
            ),
          ),
          const YMargin(24),

          // Benefit Items
          _buildBenefitItem(context, "Unlimited keyword alerts"),
          const YMargin(12),
          _buildBenefitItem(context, "Real-time notifications"),
          
          const YMargin(24),
          
          // Pricing
          Text(
            "Only \$4.99".tr(context),
            style: GiftPoseTextStyle.medium(
              fontWeight: FontWeight.w600,
              color: Colors.blueGrey,
            ),
          ),
          const YMargin(20),

          // Upgrade Button
         GiftPoseButton(title: "Upgrade", onTap: () {}),
          const YMargin(12),
          
          // Cancel Button
         GiftPoseButton(
          buttonType: GiftPoseButtonType.text,
          title: "Cancel", onTap: () {

         }),
          const YMargin(10),
        ],
      ),
    );
  }

  Widget _buildBenefitItem(BuildContext context, String text) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: const BoxDecoration(
            color: Color(0xFFE8F9E8), // Light green circle
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.check,
            size: 16,
            color: Color(0xFF32D732),
          ),
        ),
        const XMargin(12),
        Text(
          text.tr(context),
          style: GiftPoseTextStyle.small(
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}