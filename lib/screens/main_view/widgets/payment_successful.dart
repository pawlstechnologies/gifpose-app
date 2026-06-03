import 'package:flutter/material.dart';
import 'package:giftpose/utils/localization_provider.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:giftpose/app.dart';
import 'package:giftpose/gen/assets.gen.dart';
import 'package:giftpose/utils/router/app_routes.dart';
import 'package:giftpose/utils/theme/giftpose_colors.dart';
import 'package:giftpose/utils/theme/giftpose_text_style.dart';
import 'package:giftpose/utils/theme/theme.dart';
import 'package:giftpose/utils/widgets/Giftpose_basescafold.dart';
import 'package:giftpose/utils/widgets/giftpose_button.dart';
import 'package:giftpose/utils/widgets/spacing.dart';
import 'package:provider/provider.dart';

class PaymentSuccessfulScreen extends StatefulWidget {
  PaymentSuccessfulScreen({super.key});

  @override
  State<PaymentSuccessfulScreen> createState() => _PaymentSuccessfulScreenState();
}

class _PaymentSuccessfulScreenState extends State<PaymentSuccessfulScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool showSecondLogo = false; // 🔁 Toggle for logo

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  bool _isExpanded = false;

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }
    bool _isExpanded2 = false;

  void _toggleExpansion2() {
    setState(() {
      _isExpanded2 = !_isExpanded2;
    });
  }

  @override
  Widget build(BuildContext context) {
      final textColor = Theme.of(context).dividerColor;
    return GiftPoseBaseScaffold(
      showAppBar: false,
      hasGradient: true,
      includeVerticalPadding: false,

      builder: (size) {
        return Column(
          children: [
            ListView(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              children: [
                YMargin(62),
                Assets.icons.privacy.svg(height: 80,width: 80),
                YMargin(30),
                Text("Payment Successful".tr(context),
                  style: GiftPoseTextStyle.heading1(fontWeight: FontWeight.w500),
                ),
             Text("Your transaction was completed successfully.".tr(context),
                  style: GiftPoseTextStyle.heading1(fontWeight: FontWeight.w500),
                ),
            
              ],
            ),
            YMargin(10),
                GiftPoseButton(
                    title: "Go to home page",
                    onTap: () {
                     HapticFeedback.heavyImpact();
                      Navigator.pushNamed(context, AppRoutes.postcodePage);
              
                    },
                  ),

                  YMargin(12),
                
                  YMargin(40),
          ],
        );
      },
    );
  }
}
