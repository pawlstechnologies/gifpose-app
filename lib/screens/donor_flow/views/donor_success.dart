import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:giftpose/screens/donor_flow/widgets/donor_widgets.dart';
import 'package:giftpose/utils/router/app_routes.dart';
import 'package:giftpose/utils/theme/giftpose_colors.dart';
import 'package:giftpose/utils/theme/giftpose_text_style.dart';
import 'package:giftpose/utils/widgets/Giftpose_basescafold.dart';
import 'package:giftpose/utils/widgets/giftpose_button.dart';

class DonorSuccessScreen extends StatelessWidget {
  const DonorSuccessScreen({super.key, this.offer = false});

  final bool offer;

  @override
  Widget build(BuildContext context) {
    return GiftPoseBaseScaffold(
      showAppBar: false,
      includeHorizontalPadding: false,
      includeVerticalPadding: false,
      hasGradient: false,
      builder: (_) => Column(
        children: [
          SizedBox(height: offer ? 247.w : 251.w),
          Text(
            offer ? 'Offer Sent Successfully' : 'Item Posted Successfully',
            textAlign: TextAlign.center,
            style: GiftPoseTextStyle.heading1(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8.w),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 34.w),
            child: Text(
              offer
                  ? 'The requester will review your offer and notify you once they accept or decline.'
                  : 'Your Macbook laptop is now live and  visible to people',
              textAlign: TextAlign.center,
              style: GiftPoseTextStyle.normal(
                fontSize: 14,
                color: const Color(0xFF857878),
              ),
            ),
          ),
          SizedBox(height: 23.w),
          DonorItemSummary(
            image: offer
                ? 'assets/images/donor/shoes.png'
                : 'assets/images/requester/request_item_example.jpg',
          ),
          SizedBox(height: 33.w),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                GiftPoseButton(
                  title: offer ? 'My Donation' : 'View my Posting',
                  height: 49,
                  scaleHeightByWidth: true,
                  onTap: () => Navigator.pushReplacementNamed(
                    context,
                    offer
                        ? AppRoutes.donorMyDonations
                        : AppRoutes.donorItemDetails,
                  ),
                ),
                SizedBox(height: 21.w),
                GiftPoseButton(
                  title: offer ? 'Go back to Home' : 'Go back to home',
                  height: 49,
                  scaleHeightByWidth: true,
                  buttonType: GiftPoseButtonType.border,
                  backgroundColor: Colors.transparent,
                  borderColor: GiftPoseColors.borderColor,
                  textColor: Theme.of(context).textTheme.bodyLarge?.color,
                  onTap: () => Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoutes.dashboard,
                    (_) => false,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
