import 'package:flutter/material.dart';
import 'package:giftpose/utils/localization_provider.dart';

import 'package:flutter/services.dart';
import 'package:giftpose/gen/assets.gen.dart';
import 'package:giftpose/screens/main_view/widgets/faq_widget.dart';
import 'package:giftpose/screens/main_view/widgets/need_help_bottomsheet.dart';
import 'package:giftpose/utils/theme/giftpose_colors.dart';
import 'package:giftpose/utils/theme/giftpose_text_style.dart';
import 'package:giftpose/utils/widgets/Giftpose_basescafold.dart';
import 'package:giftpose/utils/widgets/bottom_sheet.dart';
import 'package:giftpose/utils/widgets/giftpose_button.dart';
import 'package:giftpose/utils/widgets/giftpose_textfield.dart';
import 'package:giftpose/utils/widgets/spacing.dart';

class ArticlePageTwo extends StatelessWidget {
  final String title;
  ArticlePageTwo({super.key, required this.title});
  final searchCtrl = TextEditingController();
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
      appBarTitleWidget: Text(
        "Article",
        textAlign: TextAlign.center,

 style: GiftPoseTextStyle.normal(fontWeight: FontWeight.w500),
      ),

      builder: (size) {
        return ListView(
          shrinkWrap: true,
          children: [
            YMargin(19),
            Text(title.tr(context),
              textAlign: TextAlign.left,

              style: GiftPoseTextStyle.medium(
                fontWeight: FontWeight.w500,

                fontSize: 22,
              ),
            ),
            Row(
              children: [
                Assets.icons.calendar.svg(),
                XMargin(5),
                Text("Last updated: April 10, 2026".tr(context),
                  textAlign: TextAlign.left,

                  style: GiftPoseTextStyle.medium(fontWeight: FontWeight.w500),
                ),
              ],
            ),

            YMargin(40),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Assets.images.tileone.svg(),
                      Assets.images.divider.image(),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Access the Gift Notifications settings by doing one of the following:  ".tr(context),
                        textAlign: TextAlign.left,

                        style: GiftPoseTextStyle.medium(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                      YMargin(5),
                      Text("""- From the Listings page, tap the “Get notified of items of interest” banner (located below your preferred postal code), **OR**  
- Go to Settings (top-left gear icon) → Gift Notifications""".tr(context),
                        textAlign: TextAlign.justify,

                        style: GiftPoseTextStyle.medium(
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            YMargin(9),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Assets.images.tiletwo.image(),
                      Assets.images.divider.image(),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Add your preferred keywords using one of these methods:".tr(context),
                        textAlign: TextAlign.left,

                        style: GiftPoseTextStyle.medium(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                      YMargin(5),
                      Text("""- Type the name of the item or category into the text field at the top and select a suggestion from the dropdown list, **OR**  
- Browse the items listed under each category and select the keywords you want.""".tr(context),
                        textAlign: TextAlign.justify,

                        style: GiftPoseTextStyle.medium(
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            YMargin(9),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(children: [Assets.images.tilethree.image()]),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Select as many keywords as you would like to receive notifications for.".tr(context),
                        textAlign: TextAlign.left,

                        style: GiftPoseTextStyle.medium(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      YMargin(5),
                      Text("".tr(context),
                        textAlign: TextAlign.justify,

                        style: GiftPoseTextStyle.medium(
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

             YMargin(9),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(children: [Assets.images.tilethree.image()]),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Tap the green “Submit” button at the bottom to activate your selected keywords.".tr(context),
                        textAlign: TextAlign.left,

                        style: GiftPoseTextStyle.medium(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      YMargin(5),
                      Text("You will now only receive alerts related to the keywords you have chosen.".tr(context),
                        textAlign: TextAlign.justify,

                        style: GiftPoseTextStyle.medium(
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
             YMargin(9),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(children:[]),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("".tr(context),
                        textAlign: TextAlign.left,

                        style: GiftPoseTextStyle.medium(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      YMargin(5),
                      Text("""- You can also reduce the search radius in the same menu to receive fewer, more relevant notifications.
- Our "Smart Notifier" feature let's our Al assistant notify you with similar items. No need to do anything, it is activated by default.""".tr(context),
                        textAlign: TextAlign.justify,

                        style: GiftPoseTextStyle.medium(
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            YMargin(20),
            Divider(color: GiftPoseColors.dividerColorNew),
            YMargin(32),
            Text("Was this article helpful?".tr(context),
              textAlign: TextAlign.center,

              style: GiftPoseTextStyle.medium(
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
            YMargin(16),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 60.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(32),
                      border: Border.all(
                        color: GiftPoseColors.dividerColorNew,
                        width: 1,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Assets.icons.like.svg(
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                          ),

                          XMargin(10),
                          Text("Yes".tr(context),
                            textAlign: TextAlign.center,

                            style: GiftPoseTextStyle.medium(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(32),
                      border: Border.all(
                        color: GiftPoseColors.dividerColorNew,
                        width: 1,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Assets.icons.dislike.svg(
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                          ),
                          XMargin(10),
                          Text("No".tr(context),
                            textAlign: TextAlign.center,

                            style: GiftPoseTextStyle.medium(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            YMargin(90),
          ],
        );
      },
    );
  }
}
