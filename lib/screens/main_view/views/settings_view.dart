import 'package:flutter/material.dart';
import 'package:giftpose/gen/assets.gen.dart';
import 'package:giftpose/utils/theme/giftpose_text_style.dart';
import 'package:giftpose/utils/theme/theme.dart';
import 'package:giftpose/utils/widgets/Giftpose_basescafold.dart';
import 'package:giftpose/utils/widgets/duration_slider.dart';
import 'package:giftpose/utils/widgets/spacing.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GiftPoseBaseScaffold(
      includeHorizontalPadding: true,

      showAppBar: true,
      includeVerticalPadding: false,
      centerTitle: true,
      appBarLeadingWidget: InkWell(
        onTap: () {
          HapticFeedback.selectionClick();
          Navigator.pop(context);
        },
        child: Assets.icons.back.svg(
          color: Theme.of(context).textTheme.bodyLarge?.color,
        ),
      ),

      hasGradient: true,
      appBarTitleWidget: Text(
        "Settings",
        textAlign: TextAlign.center,

        style: GiftPoseTextStyle.medium(fontWeight: FontWeight.w500),
      ),

      builder: (size) {
        return ListView(
          children: [
            YMargin(31),
            Text(
              "Location",

              style: GiftPoseTextStyle.small(
                color: Theme.of(context).textTheme.bodyMedium?.color,
              ),
            ),
            YMargin(10),

            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Theme.of(context).dividerColor,
                  width: 1,
                ),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.all(16),
                leading: Assets.icons.location.svg(),
                title: Text(
                  "Current Location",

                  style: GiftPoseTextStyle.small(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    "New York",

                    style: GiftPoseTextStyle.small(
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ),
                ),
                trailing: Assets.icons.foward.svg(),
              ),
            ),
            YMargin(25),

            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Theme.of(context).dividerColor,
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  Text(
                    "How far are you willing to travel?",
                    textAlign: TextAlign.center,

                    style: GiftPoseTextStyle.medium(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  YMargin(14),
                  DurationSlider(),
                ],
              ),
            ),
            YMargin(23),
            Text(
              "Notifications",

              style: GiftPoseTextStyle.small(
                color: Theme.of(context).textTheme.bodyMedium?.color,
              ),
            ),
            YMargin(10),

            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Theme.of(context).dividerColor,
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
                    leading: Assets.icons.location.svg(),
                    title: Text(
                      "Notification Alert Settings",

                      style: GiftPoseTextStyle.small(
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),

                    trailing: Assets.icons.foward.svg(),
                  ),
                  Divider(color: Theme.of(context).dividerColor),
                  ListTile(
                           contentPadding: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
                           
                    leading: Assets.icons.dot.svg(),
                    title: Text(
                      "Push Notifications",

                      style: GiftPoseTextStyle.small(
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            YMargin(25),
          ],
        );
      },
    );
  }
}
