import 'package:flutter/material.dart';
import 'package:giftpose/utils/localization_provider.dart';

import 'package:giftpose/gen/assets.gen.dart';
import 'package:giftpose/utils/theme/giftpose_colors.dart';
import 'package:giftpose/utils/theme/giftpose_text_style.dart';
import 'package:giftpose/utils/theme/theme.dart';
import 'package:giftpose/utils/widgets/Giftpose_basescafold.dart';
import 'package:giftpose/utils/widgets/spacing.dart';

class AboutPage extends StatelessWidget {
  AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GiftPoseBaseScaffold(
      showAppBar: true,
      includeVerticalPadding: false,
      includeHorizontalPadding: true,
      centerTitle: true,
      appBarLeadingWidget: InkWell(
        onTap: () {
          HapticFeedback.heavyImpact();
          Navigator.pop(context);
        },
        child: Container(
          width: 200,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              20,
            ), // Adjust the value for more/less rounding
          ),
          child: Padding(
            padding: EdgeInsets.all(14.0),
            child: Assets.icons.back.svg(
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
        ),
      ),

      hasGradient: true,
      appBarTitleWidget: Text("About Gift Pose".tr(context),
        textAlign: TextAlign.center,

 style: GiftPoseTextStyle.normal(fontWeight: FontWeight.w500),
      ),

      builder: (size) {
        return Column(
          children: [
            Assets.images.logo2.image(height: 75, width: 67),
            YMargin(19),

            Text(" GiftPose".tr(context),
              textAlign: TextAlign.center,

              style: GiftPoseTextStyle.medium(
                fontWeight: FontWeight.w500,
                fontSize: 24,
              ),
            ),

            Text("Version 1.2.0".tr(context),
              textAlign: TextAlign.center,

              style: GiftPoseTextStyle.medium(
                fontWeight: FontWeight.w500,
                color: GiftPoseColors.primaryColor,
              ),
            ),
            YMargin(12),
            Text("Spreading joy through thoughtful, personalized giving.".tr(context),
              textAlign: TextAlign.center,

              style: GiftPoseTextStyle.medium(fontWeight: FontWeight.w500),
            ),
            YMargin(34),

            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.withOpacity(0.1)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Our Mission".tr(context),
                    textAlign: TextAlign.center,

                    style: GiftPoseTextStyle.medium(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  YMargin(12),

                  Text("""At GiftPose, we believe that the
perfect gift is an expression of
connection. Our mission is to make
thoughtful gifting effortless, helping
you discover meaningful presents thatresonate with the people you care about most.""".tr(context),
                    textAlign: TextAlign.justify,

                    style: GiftPoseTextStyle.medium(
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
 YMargin(12),

              Text("Follow Us".tr(context),
                    textAlign: TextAlign.center,

                    style: GiftPoseTextStyle.medium(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
              YMargin(25),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Assets.icons.fb.svg(),
                             Assets.icons.ig.svg(),
                    ],
                  ),

         YMargin(25),

                 Text("© 2026 GiftPose Inc. All rights reserved.".tr(context),
                    textAlign: TextAlign.center,

                    style: GiftPoseTextStyle.medium(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  YMargin(12),
          ],
        );
      },
    );
  }
}
