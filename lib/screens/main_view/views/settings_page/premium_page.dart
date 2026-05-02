import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:giftpose/gen/assets.gen.dart';
import 'package:giftpose/screens/main_view/viewmodels/dashboard_viewmodel.dart';
import 'package:giftpose/utils/theme/giftpose_text_style.dart';
import 'package:giftpose/utils/widgets/Giftpose_basescafold.dart';
import 'package:giftpose/utils/widgets/giftpose_button.dart';
import 'package:giftpose/utils/widgets/spacing.dart';
import 'package:provider/provider.dart';

class PremiumSubscriptionView extends StatelessWidget {
  const PremiumSubscriptionView({super.key});

  @override
  Widget build(BuildContext context) {
 return Consumer<DashboardViewmodel>(
      builder: (context, viewModel, child) {
        return GiftPoseBaseScaffold(
          includeHorizontalPadding: true,
          includeVerticalPadding: false,
          showAppBar: false,
        
          builder: (size) {
            return Column(
              children: [
                /// TOP SECTION
                Expanded(
                  child: ListView(
                    children: [
                      /// HEADER
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              HapticFeedback.heavyImpact();
                              Navigator.pop(context);
                            },
                            child: SizedBox(
                              width: 50,
                              height: 40,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Assets.icons.back.svg(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.color,
                                ),
                              ),
                            ),
                          ),
        
                          Text(
                            "Premium Subscription",
                            style: GiftPoseTextStyle.normal(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
        
                          SizedBox(width: 50), // balance spacing
                        ],
                      ),
        
           
        YMargin(20),
                   Assets.images.paymentImage.image(height: 128, width: 128),
        
                         YMargin(20),
        
                      /// FEATURES
                      _featureItem(
                        context,
                        icon: Assets.icons.adfree.svg(),
                        title: "Ad-Free Browsing",
                        subtitle:
                            "Remove all banners and pop-ups for a cleaner experience while browsing or listing.",
                      ),
        
                      _featureItem(
                        context,
                        icon:Assets.icons.supporter.svg(),
                        title: "Supporter Badge",
                        subtitle:
                            "A unique badge on your profile to show you're a dedicated community member.",
                      ),
        
                      _featureItem(
                        context,
                        icon: Assets.icons.premiumSvg.svg(),
                        title: "Premium Support",
                        subtitle:
                            "Enjoy fast, reliable support with priority access to our team whenever you need help.",
                      ),
        
                      _featureItem(
                        context,
                        icon: Assets.icons.unlimited.svg(),
                        title: "Unlimited Smart Notification",
                        subtitle:
                            "Choose how and when you get notified about your gift.",
                      ),
        
                      _featureItem(
                        context,
                        icon: Assets.icons.featured.svg(),
                        title: "Featured Listings (coming soon)",
                        subtitle:
                            "Give your items more visibility so they find a new home faster.",
                      ),
        
                      YMargin(25),
        
                      /// PRICING CARD
                      Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.green,
                            width: 2,
                          ),
                        ),
                        child: Stack(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Annual",
                                  style: GiftPoseTextStyle.medium(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                YMargin(10),
                                Text(
                                  "\$4.99 /yr",
                                  style: GiftPoseTextStyle.large(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                YMargin(6),
                                Text(
                                  "Get value for your money",
                                  style: GiftPoseTextStyle.small(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.color,
                                  ),
                                ),
                              ],
                            ),
        
                            /// BEST VALUE TAG
                            Positioned(
                              right: 0,
                              top: 0,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(12),
                                    bottomLeft: Radius.circular(12),
                                  ),
                                ),
                                child: Text(
                                  "Best Value",
                                  style: GiftPoseTextStyle.small(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
        
                      YMargin(20),
                    ],
                  ),
                ),
            YMargin(10),
                /// SUBSCRIBE BUTTON
                GiftPoseButton( 
                 title: "Subscribe",
                 onTap: () {
                   HapticFeedback.heavyImpact();
                   print("start");
                   viewModel.createPaymentIntent();
                   
        
                   /// 👉 Hook Stripe here
                 }, 
                ),
        
                YMargin(40),
              ],
            );
          },
        );
      }
    );
  }

  /// FEATURE ITEM WIDGET
  Widget _featureItem(
    BuildContext context, {
    required Widget icon,
    required String title,
    required String subtitle,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: Theme.of(context).dividerColor.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Center(child: icon),
          ),

          XMargin(12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GiftPoseTextStyle.medium(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                YMargin(4),
                Text(
                  subtitle,
                  style: GiftPoseTextStyle.small(
                    color:
                        Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}