import 'package:flutter/material.dart';
import 'package:giftpose/utils/localization_provider.dart';

import 'package:giftpose/gen/assets.gen.dart';
import 'package:giftpose/utils/theme/giftpose_colors.dart';
import 'package:giftpose/utils/theme/giftpose_text_style.dart';
import 'package:giftpose/utils/theme/theme.dart';
import 'package:giftpose/utils/widgets/Giftpose_basescafold.dart';
import 'package:giftpose/utils/widgets/spacing.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  AboutPage({super.key});



 Future<void> launchInstagramURL() async {
    final Uri url = Uri.parse(
        'https://instagram.com/giftpose');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

   Future<void> launchTwitterURL() async {
    final Uri url = Uri.parse('https://x.com/giftpose_app');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
 Future<void> launchTiktokURL() async {
    final Uri url = Uri.parse('https://tiktok.com/@giftpose');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }



  Future<void> launchFacebookURL() async {
    final Uri url = Uri.parse('https://www.facebook.com/share/17pe7W6k2f/');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

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
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: launchInstagramURL,
                        child: Assets.icons.insta.svg(),
                      ),
                      InkWell(
                        onTap: launchTwitterURL,
                        child: Assets.icons.twitter.svg(),
                      ),
                      InkWell(
                        onTap: launchFacebookURL,
                        child: Assets.icons.face.svg(),
                      ),
                      InkWell(
                        onTap: launchTiktokURL,
                        child: Assets.icons.tiktok.svg(),
                      )
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
