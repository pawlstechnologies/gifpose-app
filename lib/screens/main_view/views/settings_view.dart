import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:giftpose/screens/main_view/widgets/settings_bottomsheet.dart';
import 'package:giftpose/services/secure_storage/secure_storage.dart';
import 'package:giftpose/utils/constants/storage_keys.dart';
import 'package:giftpose/utils/localization_provider.dart';

import 'package:giftpose/gen/assets.gen.dart';
import 'package:giftpose/screens/main_view/viewmodels/dashboard_viewmodel.dart';
import 'package:giftpose/screens/main_view/views/notification_alert.dart';
import 'package:giftpose/screens/onboarding/views/postcode_view.dart';
import 'package:giftpose/utils/locator.dart';
import 'package:giftpose/utils/router/app_routes.dart';
import 'package:giftpose/utils/theme/giftpose_colors.dart';
import 'package:giftpose/utils/theme/giftpose_text_style.dart';
import 'package:giftpose/utils/theme/theme.dart';
import 'package:giftpose/utils/widgets/Giftpose_basescafold.dart';
import 'package:giftpose/utils/widgets/duration_slider.dart';
import 'package:giftpose/utils/widgets/giftpose_button.dart';
import 'package:giftpose/utils/widgets/giftpose_switch.dart';
import 'package:giftpose/utils/widgets/premium_card.dart';
import 'package:giftpose/utils/widgets/spacing.dart';
import 'package:giftpose/screens/authentication/repo/authentication_repo.dart';
import 'package:provider/provider.dart';

class SettingsView extends StatefulWidget {
  SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  bool push = true;
  bool _isSignedIn = false;
  final SecureStorageService _secureStorageService =
      serviceLocator<SecureStorageService>();

  @override
  void initState() {
    super.initState();
    _checkSignInStatus();
    final viewModel = context.read<DashboardViewmodel>();
    viewModel.checkCurrentUser();
    viewModel.fetchSubscriptionList();
    viewModel.fetchCurrentSubscription();
  }

  Future<void> _checkSignInStatus() async {
    final token = await _secureStorageService.read(
      key: StorageKeys.accessToken,
    );
    if (mounted) {
      setState(() {
        _isSignedIn = token != null && token.isNotEmpty;
      });
    }
  }

  String _getFormattedPeriodEnd(DashboardViewmodel viewModel) {
    final rawDate =
        viewModel.currentSubscriptionResponse?.data?.currentPeriodEnd;
    if (rawDate == null || rawDate.trim().isEmpty) return "";
    try {
      final parsed = DateTime.tryParse(rawDate);
      if (parsed != null) {
        return DateFormat("MMM yyyy").format(parsed);
      }
    } catch (_) {}
    return rawDate;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardViewmodel>(
      builder: (context, viewModel, child) {
        final isUserSignedIn =
            _isSignedIn || (viewModel.currentUser?.user != null);
        final user = viewModel.currentUser?.user;
        String displayName = "User";
        if (user != null) {
          if (user.fullname.isNotEmpty) {
            displayName = user.fullname;
          } else if (user.username.isNotEmpty) {
            displayName = user.username;
          }
        }

        return GiftPoseBaseScaffold(
          includeHorizontalPadding: true,

          showAppBar: false,
          includeVerticalPadding: false,
          centerTitle: true,

          builder: (size) {
            return SafeArea(
              child: ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          HapticFeedback.heavyImpact();
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: 50,
                          height: 40,

                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Assets.icons.back.svg(
                              color: Theme.of(
                                context,
                              ).textTheme.bodyLarge?.color,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        "Settings".tr(context),
                        textAlign: TextAlign.center,

                        style: GiftPoseTextStyle.normal(
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      PopupMenuButton<String>(
                        icon: const Icon(Icons.menu),
                        onSelected: (value) {
                          if (value == 'delete') {
                            HapticFeedback.heavyImpact();
                            Future.delayed(
                              const Duration(milliseconds: 100),
                              () {
                                if (!context.mounted) return;
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    ),
                                  ),
                                  builder: (_) => SettingsBottomsheet(),
                                );
                              },
                            );
                          } else if (value == 'logout') {
                            HapticFeedback.heavyImpact();
                            Future.microtask(() async {
                              try {
                                final authRepo =
                                    serviceLocator<AuthenticationRepo>();
                                await authRepo.logout();
                              } catch (_) {}
                              final secureStorageService =
                                  serviceLocator<SecureStorageService>();
                              await secureStorageService.delete(
                                key: StorageKeys.accessToken,
                              );
                              if (context.mounted) {
                                context.read<DashboardViewmodel>().clearUser();
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  AppRoutes.siginInPage,
                                  (route) => false,
                                );
                              }
                            });
                          } else if (value == 'delete') {
                            HapticFeedback.heavyImpact();
                            Navigator.pushNamed(
                              context,
                              AppRoutes.deleteAccountPage,
                            );
                          } else if (value == 'signup') {
                            HapticFeedback.heavyImpact();
                            Navigator.pushNamed(
                              context,
                              AppRoutes.createAccountPage,
                            ).then((value) {
                              _checkSignInStatus();
                            });
                          }
                        },
                        itemBuilder: (context) => isUserSignedIn
                            ? [
                                PopupMenuItem(
                                  value: 'logout',
                                  child: Text(
                                    "Log Out".tr(context, listen: false),
                                  ),
                                ),
                                PopupMenuItem(
                                  value: 'delete',
                                  child: Text(
                                    "Delete Account".tr(context, listen: false),
                                  ),
                                ),
                              ]
                            : [
                                PopupMenuItem(
                                  value: 'signup',
                                  child: Text(
                                    "Sign Up".tr(context, listen: false),
                                  ),
                                ),
                              ],
                      ),
                    ],
                  ),

                  // Top Banner 1: Account Successfully Restored
                  if (viewModel.showAccountRestoredBanner) ...[
                    Container(
                      margin: EdgeInsets.only(bottom: 16.h),
                      padding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                        vertical: 10.h,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(12.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 28.r,
                            height: 28.r,
                            decoration: const BoxDecoration(
                              color: Color(0xFF39D11F),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.check_rounded,
                              color: Colors.white,
                              size: 18.r,
                            ),
                          ),
                          XMargin(10.w),
                          Expanded(
                            child: Text(
                              "Account successfully restored".tr(context),
                              style: GiftPoseTextStyle.small(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(
                                  context,
                                ).textTheme.bodyLarge?.color,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              viewModel.dismissAccountRestoredBanner();
                            },
                            child: Padding(
                              padding: EdgeInsets.all(4.r),
                              child: const Icon(
                                Icons.close_rounded,
                                size: 20,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  // Top Banner 2: Account Deletion Pending
                  if (viewModel.isAccountDeletionPending) ...[
                    Container(
                      margin: EdgeInsets.only(bottom: 20.h),
                      padding: EdgeInsets.all(16.r),
                      decoration: BoxDecoration(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? const Color(0xFF3D1E1E)
                            : const Color(0xFFFFEBEB),
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? const Color(0xFF7A2E2E)
                              : const Color(0xFFFFC1C1),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.warning_rounded,
                                color: const Color(0xFFC62828),
                                size: 24.r,
                              ),
                              XMargin(8.w),
                              Text(
                                "Account Deletion Pending".tr(context),
                                style: GiftPoseTextStyle.medium(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFFC62828),
                                ),
                              ),
                            ],
                          ),
                          YMargin(6.h),
                          RichText(
                            text: TextSpan(
                              style: GiftPoseTextStyle.small(
                                fontSize: 13.sp,
                                color:
                                    Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.grey.shade300
                                    : Colors.grey.shade800,
                              ),
                              children: [
                                TextSpan(
                                  text:
                                      "Your account will be permanently deleted in "
                                          .tr(context),
                                ),
                                TextSpan(
                                  text:
                                      "${viewModel.deletionDaysRemaining} days."
                                          .tr(context),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          YMargin(14.h),
                          SizedBox(
                            width: double.infinity,
                            height: 44.h,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFC62828),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                              ),
                              onPressed: () {
                                HapticFeedback.heavyImpact();
                                viewModel.restoreAccount();
                              },
                              child: Text(
                                "Restore My Account".tr(context),
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  if (isUserSignedIn) ...[
                    Center(
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: const BoxDecoration(
                          color: Color(0xFFE5ECF9),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.person,
                          size: 40,
                          color: Color(0xFF334237),
                        ),
                      ),
                    ),
                    YMargin(5),
                    Text(
                      displayName,
                      textAlign: TextAlign.center,
                      style: GiftPoseTextStyle.small(
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),
                    YMargin(2),
                    Text(
                      user?.email ?? "",
                      textAlign: TextAlign.center,
                      style: GiftPoseTextStyle.small(
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),
                  ] else ...[
                    // Guest User centered avatar
                    Center(
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: const BoxDecoration(
                          color: Color(0xFFE5ECF9),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.person,
                          size: 40,
                          color: Color(0xFF334237),
                        ),
                      ),
                    ),
                    YMargin(5),
                    Text(
                      "Guest User".tr(context),
                      textAlign: TextAlign.center,
                      style: GiftPoseTextStyle.large(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),
                    YMargin(12),
                    GestureDetector(
                      onTap: () {
                        HapticFeedback.heavyImpact();
                        Navigator.pushNamed(
                          context,
                          AppRoutes.siginInPage,
                        ).then((value) {
                          _checkSignInStatus();
                        });
                      },
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.only(bottom: 2),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Color(0xff39D11F),
                                width: 1.5,
                              ),
                            ),
                          ),
                          child: Text(
                            "Sign In".tr(context),
                            textAlign: TextAlign.center,
                            style: GiftPoseTextStyle.normal(
                              color: const Color(0xff39D11F),
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                  YMargin(16),
                  (isUserSignedIn && viewModel.isSubscribed)
                      ? InkWell(
                          onTap: () {
                            HapticFeedback.heavyImpact();
                            Navigator.pushNamed(
                              context,
                              AppRoutes.premiumSubscription,
                            );
                          },
                          child: PremiumMemberCard(
                            activeUntil: _getFormattedPeriodEnd(viewModel),
                          ),
                        )
                      : InkWell(
                          onTap: () {
                            HapticFeedback.heavyImpact();
                            Navigator.pushNamed(
                              context,
                              AppRoutes.premiumSubscription,
                            );
                          },
                          child: PremiumUpgradeCard(isSettings: true),
                        ),

                  YMargin(16),
                  Text(
                    "Location".tr(context),

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
                    child: Material(
                      color: Colors.transparent,
                      child: ListTile(
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
                    child: Material(
                      color: Colors.transparent,
                      child: Column(
                        children: [
                          ListTile(
                            onTap: () {
                              HapticFeedback.heavyImpact();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NotificationAlert(),
                                ),
                              );
                            },
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 10,
                            ),
                            leading: Assets.icons.notificationIcon.svg(),
                            title: Text(
                              "Gift Notifications".tr(context),

                              style: GiftPoseTextStyle.small(
                                color: Theme.of(
                                  context,
                                ).textTheme.bodyLarge?.color,
                              ),
                            ),

                            trailing: Assets.icons.foward.svg(),
                          ),
                          Divider(color: Theme.of(context).dividerColor),
                          ListTile(
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 10,
                            ),

                            leading: Assets.icons.notificationIcon.svg(),
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
                        ],
                      ),
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
                    child: Material(
                      color: Colors.transparent,
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
                                color: Theme.of(
                                  context,
                                ).textTheme.bodyLarge?.color,
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
                          YMargin(10),
                          Divider(color: Theme.of(context).dividerColor),
                          ListTile(
                            onTap: () {
                              HapticFeedback.heavyImpact();
                              Navigator.pushNamed(
                                context,
                                AppRoutes.premiumSubscription,
                              );
                            },

                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 10,
                            ),
                            leading: Assets.icons.ads.svg(),
                            title: Text(
                              "Remove ads".tr(context),

                              style: GiftPoseTextStyle.small(
                                color: Theme.of(
                                  context,
                                ).textTheme.bodyLarge?.color,
                              ),
                            ),
                            trailing: Assets.icons.foward.svg(),
                          ),
                        ],
                      ),
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
                    child: Material(
                      color: Colors.transparent,
                      child: Column(
                        children: [
                          ListTile(
                            onTap: () {
                              HapticFeedback.heavyImpact();
                              Navigator.pushNamed(context, AppRoutes.helpCenter);
                            },

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
                ),
                YMargin(85),
              ],
              ),
            );
          },
        );
      },
    );
  }
}
