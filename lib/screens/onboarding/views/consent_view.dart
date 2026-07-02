import 'package:firebase_messaging/firebase_messaging.dart';
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
import 'package:url_launcher/url_launcher.dart';

class ConsentScreen extends StatefulWidget {
  ConsentScreen({super.key});

  @override
  State<ConsentScreen> createState() => _ConsentScreenState();
}

class _ConsentScreenState extends State<ConsentScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool showSecondLogo = false; // 🔁 Toggle for logo

  @override
  void initState() {
    initFirebase();
    super.initState();
  }

  void initFirebase() async {
    // Request Permissions
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future<void> _launchPrivacyPolicy() async {
    final Uri url = Uri.parse('https://giftpose.com/privacy-policy');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
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
            Expanded(
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                children: [
                  YMargin(62),
                  Assets.icons.privacy.svg(height: 80,width: 80),
                  YMargin(30),
                  Text("Privacy Preferences".tr(context),
                    style: GiftPoseTextStyle.heading1(fontWeight: FontWeight.w500),
                  ),
                  YMargin(16),
              
                  Text("GiftPose uses cookies and similar technologies to provide you with our services, measure and improve performance, and customise our marketing campaigns. You can change your cookie preferences below at any time.".tr(context),
                    textAlign: TextAlign.justify,
              
                    style: GiftPoseTextStyle.medium(fontWeight: FontWeight.w500,color: Theme.of(navigatorKey.currentContext!).textTheme.bodyMedium?.color),
                  ),
              
                  YMargin(18),
              
               Row(
                 children: [
                   Text("For more information, visit our".tr(context),
                        textAlign: TextAlign.justify,
                   
                        style: GiftPoseTextStyle.medium(fontWeight: FontWeight.w500,color: Theme.of(navigatorKey.currentContext!).textTheme.bodyMedium?.color),
                      ),
                      XMargin(5),
                      InkWell(
                        onTap: _launchPrivacyPolicy,
                        child: Text("Privacy Policy Page".tr(context),
                          textAlign: TextAlign.justify,
                    
                          style: GiftPoseTextStyle.medium(fontWeight: FontWeight.w500,color: GiftPoseColors.primaryColor),
                        ),
                      ),
                 ],
               ),
              
              
               YMargin(10),
              InkWell(
                    onTap: () => _toggleExpansion(),
                  child: Row(
                    children: [
              Text("Essentials".tr(context),
                              textAlign: TextAlign.justify,
                 
                              style: GiftPoseTextStyle.medium(fontWeight: FontWeight.w500,color: Theme.of(navigatorKey.currentContext!).textTheme.bodyLarge?.color),
                            ),
                                XMargin(5),
                            _isExpanded?Assets.icons.up.svg(color: Theme.of(navigatorKey.currentContext!).textTheme.bodyMedium?.color):
                            Assets.icons.down.svg(color: Theme.of(navigatorKey.currentContext!).textTheme.bodyMedium?.color),
                    ],
                  ),
                ),
                YMargin(10),
              
                if(_isExpanded)
                  Text("These are necessary for the app to work. Without these cookies, we can't provide you with functionalities and services such as login and security. We also receive information about the contents and ads you view and how you use the app. We use this to measure what programmes and ads are effective and to improve the user experience. We do not use your name or email for measurement purposes.".tr(context),
                              textAlign: TextAlign.justify,
                 
                              style: GiftPoseTextStyle.medium(fontWeight: FontWeight.w500,color: Theme.of(navigatorKey.currentContext!).textTheme.bodyMedium?.color),
                            ),     if(_isExpanded)YMargin(30),
                    
              
                  InkWell(
                    onTap: () => _toggleExpansion2(),
                    child: Row(
                    children: [
              Text("Performance and Functionality".tr(context),
                              textAlign: TextAlign.justify,
                 
                              style: GiftPoseTextStyle.medium(fontWeight: FontWeight.w500,color: Theme.of(navigatorKey.currentContext!).textTheme.bodyLarge?.color),
                            ),
                            XMargin(5),
                               _isExpanded2?Assets.icons.up.svg(color: Theme.of(navigatorKey.currentContext!).textTheme.bodyMedium?.color):
                            Assets.icons.down.svg(color: Theme.of(navigatorKey.currentContext!).textTheme.bodyMedium?.color),
                    ],
              ),
                  ),
                         YMargin(10),
              
                  if(_isExpanded2)
                  Text("These are used to produce anonymous reports to help us improve our site and measure how well new features or functionalities perform. We don't use this data to show you personalised ads.".tr(context),
                              textAlign: TextAlign.justify,
                 
                              style: GiftPoseTextStyle.medium(fontWeight: FontWeight.w500,color: Theme.of(navigatorKey.currentContext!).textTheme.bodyMedium?.color),
                            ),
                                    if(_isExpanded)  YMargin(30),
                
              
              
                ],
              ),
            ),
            YMargin(10),
                GiftPoseButton(
                    title: "Accept All",
                    onTap: () {
                     HapticFeedback.heavyImpact();
                      Navigator.pushNamed(context, AppRoutes.postcodePage);
              
                    },
                  ),
                  YMargin(12),
                    GiftPoseButton(
                    title: "Choose essentials",
                       borderColor: textColor,
                         textColor: Theme.of(
                                      context,
                                    ).textTheme.bodyLarge?.color,
                           backgroundColor: 
                                       Theme.of(
                                            context,
                                          ).scaffoldBackgroundColor,
                                      buttonType: GiftPoseButtonType.border,
                    onTap: () {
                     HapticFeedback.heavyImpact();
                      Navigator.pushNamed(context, AppRoutes.postcodePage);
              
                    },
                  ),
                  YMargin(40),
          ],
        );
      },
    );
  }
}
