import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:giftpose/gen/assets.gen.dart';
import 'package:giftpose/screens/main_view/viewmodels/dashboard_viewmodel.dart';
import 'package:giftpose/utils/theme/giftpose_text_style.dart';
import 'package:giftpose/utils/widgets/Giftpose_basescafold.dart';
import 'package:giftpose/utils/widgets/giftpose_button.dart';
import 'package:giftpose/utils/widgets/spacing.dart';
import 'package:provider/provider.dart';

class PremiumSubscriptionView extends StatefulWidget {
  const PremiumSubscriptionView({super.key});

  @override
  State<PremiumSubscriptionView> createState() =>
      _PremiumSubscriptionViewState();
}

class _PremiumSubscriptionViewState extends State<PremiumSubscriptionView> {
  bool isYearlySelected = true;

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardViewmodel>(
      builder: (context, viewModel, child) {
        return GiftPoseBaseScaffold(
          showAppBar: false,
          includeVerticalPadding: false,
          includeHorizontalPadding: true,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          builder: (size) {
            return Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      const SizedBox(height: 15),

                      /// HEADER
                      SizedBox(
                        height: 56,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: InkWell(
                                onTap: () {
                                  HapticFeedback.heavyImpact();
                                  Navigator.pop(context);
                                },
                                child: SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: Center(
                                    child: Assets.icons.back.svg(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.color,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              "Premium Subscription",
                              style: GiftPoseTextStyle.medium(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 25),

                      /// PREMIUM IMAGE
                      Center(
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              width: 130,
                              height: 130,
                              decoration: BoxDecoration(
                                color: const Color(0xff39D11F),
                                borderRadius: BorderRadius.circular(28),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(.08),
                                    blurRadius: 25,
                                    offset: const Offset(0, 10),
                                  )
                                ],
                              ),
                              child: Center(
                                child: Assets.images.paymentImage.image(
                                  width: 70,
                                  height: 70,
                                ),
                              ),
                            ),

                            Positioned(
                              top: -6,
                              right: -10,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 7,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xffF56D8A),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Text(
                                  "AD FREE",
                                  style: GiftPoseTextStyle.small(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 35),

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
                        icon: Assets.icons.supporter.svg(),
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

                      const SizedBox(height: 20),

                      /// PLANS
                      Row(
                        children: [
                          Expanded(
                            child: _planCard(
                              selected: !isYearlySelected,
                              duration: "1 Month",
                              monthlyText: "£0.99/mo",
                              price: "£0.99",
                              onTap: () {
                                setState(() {
                                  isYearlySelected = false;
                                });
                              },
                            ),
                          ),

                          const SizedBox(width: 16),

                          Expanded(
                            child: _planCard(
                              selected: isYearlySelected,
                              duration: "12 Months",
                              oldPrice: "£11.99",
                              savings: "Save £1.99",
                              badge: "🔥 16% OFF",
                              price: "£9.99",
                              onTap: () {
                                setState(() {
                                  isYearlySelected = true;
                                });
                              },
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 30),
                    ],
                  ),
                ),

                /// SUBSCRIBE BUTTON
                GiftPoseButton(
                  title: "Subscribe",
                  onTap: () {
                    HapticFeedback.heavyImpact();
                    viewModel.createPaymentIntent(plan: isYearlySelected?"annual": "monthly");
                  },
                ),

                const SizedBox(height: 30),
              ],
            );
          },
        );
      },
    );
  }

  Widget _featureItem(
    BuildContext context, {
    required Widget icon,
    required String title,
    required String subtitle,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 22),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: icon),
          const SizedBox(width: 14),
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
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: GiftPoseTextStyle.small(
                    color: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.color
                        ?.withOpacity(.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _planCard({
    required bool selected,
    required String duration,
    required String price,
    String? oldPrice,
    String? savings,
    String? badge,
    String? monthlyText,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 170,
        decoration: BoxDecoration(
    color:  Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color:
                selected ? const Color(0xff39D11F) : Colors.grey.shade300,
            width: selected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.03),
              blurRadius: 15,
            )
          ],
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            if (badge != null)
              Positioned(
                top: -14,
                left: 30,
                right: 30,
                child: Container(
                  height: 28,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(0xff39D11F),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    badge,
                    style: GiftPoseTextStyle.small(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      duration,
                      style: GiftPoseTextStyle.medium(
                        fontWeight: FontWeight.w400,
                        fontSize: 18
                      ),
                    ),

                    const SizedBox(height: 12),

                    if (oldPrice != null)
                      Text(
                        oldPrice,
                        style: GiftPoseTextStyle.small(
                          decoration: TextDecoration.lineThrough,      fontWeight: FontWeight.w400,
                          color: Colors.grey,
                          fontSize: 14
                        ),
                      ),

                    if (savings != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          savings,
                          style: GiftPoseTextStyle.small(
                            color: const Color(0xffC77C2A),
                            fontWeight: FontWeight.w400,
                            fontSize: 14
                          ),
                        ),
                      ),

                    const SizedBox(height: 6),

                    Text(
                      price,
                      style: GiftPoseTextStyle.large(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.bodyLarge?.color
                      ),
                    ),

                    if (monthlyText != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        monthlyText,
                        style: GiftPoseTextStyle.small(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}