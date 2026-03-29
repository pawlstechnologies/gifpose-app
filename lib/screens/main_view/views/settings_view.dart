import 'package:flutter/material.dart';
import 'package:giftpose/utils/localization_provider.dart';

import 'package:giftpose/gen/assets.gen.dart';
import 'package:giftpose/screens/main_view/viewmodels/dashboard_viewmodel.dart';
import 'package:giftpose/screens/main_view/views/notification_alert.dart';
import 'package:giftpose/screens/onboarding/views/postcode_view.dart';
import 'package:giftpose/utils/router/app_routes.dart';
import 'package:giftpose/utils/theme/giftpose_text_style.dart';
import 'package:giftpose/utils/theme/theme.dart';
import 'package:giftpose/utils/widgets/Giftpose_basescafold.dart';
import 'package:giftpose/utils/widgets/duration_slider.dart';
import 'package:giftpose/utils/widgets/giftpose_switch.dart';
import 'package:giftpose/utils/widgets/spacing.dart';
import 'package:provider/provider.dart';

class SettingsView extends StatefulWidget {
  SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  bool push = true;

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardViewmodel>(
      builder: (context, viewModel, child) {
        return GiftPoseBaseScaffold(
          includeHorizontalPadding: true,

          showAppBar: true,
          includeVerticalPadding: false,
          centerTitle: true,
          appBarLeadingWidget: InkWell(
            onTap: () {
              HapticFeedback.heavyImpact();
              Navigator.pop(context);
            },
            child: Container(
              width: 60,
              height: 40,

              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Assets.icons.back.svg(
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
            ),
          ),

          hasGradient: true,
          appBarTitleWidget: Text(
            "Settings".tr(context),
            textAlign: TextAlign.center,

            style: GiftPoseTextStyle.medium(fontWeight: FontWeight.w500),
          ),

          builder: (size) {
            return ListView(
              children: [
                YMargin(31),
                Text(
                  "Location".tr(context),

                  style: GiftPoseTextStyle.small(
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                ),
                YMargin(10),

                InkWell(
                  onTap: () {
                    HapticFeedback.heavyImpact();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PostcodeScreen(fromDashboard: true),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Theme.of(context).dividerColor,
                        width: 1,
                      ),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(14),
                      leading: Assets.icons.location.svg(),
                      title: Text(
                        "Current Location".tr(context),

                        style: GiftPoseTextStyle.small(
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                        ),
                      ),
                      subtitle: Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Text(
                          viewModel
                                  .fetchItemsNearMeResponse
                                  .data
                                  ?.userLocation
                                  .city ??
                              "",

                          style: GiftPoseTextStyle.small(
                            color: Theme.of(
                              context,
                            ).textTheme.bodyMedium?.color,
                          ),
                        ),
                      ),
                      trailing: Assets.icons.foward.svg(),
                    ),
                  ),
                ),
                YMargin(25),

                InkWell(
                  onTap: () {
                    HapticFeedback.heavyImpact();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PostcodeScreen(fromDashboard: true),
                      ),
                    );
                  },
                  child: Container(
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
                          "How far are you willing to travel?".tr(context),
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
                ),
                YMargin(23),
                Text(
                  "Notifications".tr(context),

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
                      InkWell(
                        onTap: () {
                          HapticFeedback.heavyImpact();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NotificationAlert(),
                            ),
                          );
                        },
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 10,
                          ),
                          leading: Assets.icons.notificationIcon.svg(),
                          title: Text(
                            "Notification Alert Settings".tr(context),

                            style: GiftPoseTextStyle.small(
                              color: Theme.of(
                                context,
                              ).textTheme.bodyLarge?.color,
                            ),
                          ),

                          trailing: Assets.icons.foward.svg(),
                        ),
                      ),
                      Divider(color: Theme.of(context).dividerColor),
                      InkWell(
                        onTap: () {
                          HapticFeedback.heavyImpact();
                        },
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 10,
                          ),

                          leading: Assets.icons.dot.svg(),
                          title: Text(
                            "Push Notifications".tr(context),

                            style: GiftPoseTextStyle.small(
                              color: Theme.of(
                                context,
                              ).textTheme.bodyLarge?.color,
                            ),
                          ),
                          trailing: GiftPoseSwitch(
                            value: push,
                            onChanged: (bool value) {
                              push = !push;
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                YMargin(25),

                Text(
                  "App Settings".tr(context),

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
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        leading: Assets.icons.darkmode.svg(),
                        title: Text(
                          "Dark Mode".tr(context),

                          style: GiftPoseTextStyle.small(
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                          ),
                        ),
                        trailing: GiftPoseSwitch(
                          value: viewModel.isDarkMode,
                          onChanged: (bool value) {
                            viewModel.toggleTheme(context);
                          },
                        ),
                      ),
                      Divider(color: Theme.of(context).dividerColor),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                        child: InkWell(
                          onTap: () {
                            HapticFeedback.heavyImpact();
                            Navigator.pushNamed(
                              context,
                              AppRoutes.languagePage,
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Assets.icons.language.svg(),
                                  XMargin(15),
                                  Text(
                                    "Language".tr(context),

                                    style: GiftPoseTextStyle.small(
                                      color: Theme.of(
                                        context,
                                      ).textTheme.bodyLarge?.color,
                                    ),
                                  ),
                                ],
                              ),

                              Row(
                                children: [
                                  Text(
                                    "English".tr(context),

                                    style: GiftPoseTextStyle.small(
                                      color: Theme.of(
                                        context,
                                      ).textTheme.bodyLarge?.color,
                                    ),
                                  ),
                                  XMargin(8),
                                  Assets.icons.foward.svg(),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                YMargin(25),
                Text(
                  "Support".tr(context),

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
                      InkWell(
                        onTap: () {
                          HapticFeedback.heavyImpact();
                          Navigator.pushNamed(context, AppRoutes.helpCenter);
                        },

                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 10,
                          ),
                          leading: Assets.icons.helpcentre.svg(),
                          title: Text(
                            "Help Center".tr(context),

                            style: GiftPoseTextStyle.small(
                              color: Theme.of(
                                context,
                              ).textTheme.bodyLarge?.color,
                            ),
                          ),
                          trailing: Assets.icons.foward.svg(),
                        ),
                      ),
                      Divider(color: Theme.of(context).dividerColor),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                        child: InkWell(
                          onTap: () {
                            HapticFeedback.heavyImpact();
                            Navigator.pushNamed(context, AppRoutes.aboutPage);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Assets.icons.about.svg(),
                                  XMargin(15),
                                  Text(
                                    "About GiftPose".tr(context),

                                    style: GiftPoseTextStyle.small(
                                      color: Theme.of(
                                        context,
                                      ).textTheme.bodyLarge?.color,
                                    ),
                                  ),
                                ],
                              ),

                              Row(
                                children: [
                                  Text(
                                    "v1.0.0".tr(context),

                                    style: GiftPoseTextStyle.small(
                                      color: Theme.of(
                                        context,
                                      ).textTheme.bodyLarge?.color,
                                    ),
                                  ),
                                  XMargin(8),
                                  Assets.icons.foward.svg(),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                YMargin(85),
              ],
            );
          },
        );
      },
    );
  }
}
