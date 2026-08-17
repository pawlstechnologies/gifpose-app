import 'package:flutter/gestures.dart';
import 'package:giftpose/utils/localization_provider.dart';

import 'package:flutter/material.dart';
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

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool showSecondLogo = false; // 🔁 Toggle for logo
  bool _isAgreed = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return GiftPoseBaseScaffold(
      includeHorizontalPadding: false,
      includeVerticalPadding: false,
      showAppBar: false,
      hasGradient: true,

      builder: (size) {
        return Column(
          children: [
          Assets.images.splashim.image(fit: BoxFit.contain),

            YMargin(50),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Assets.images.wave.image(height: 42.h, width: 33),
                  XMargin(15),
                  Text(
                    "Welcome".tr(context),
                    style: GiftPoseTextStyle.heading1(
                      // The base color that will be gradient-masked
                    ),
                  ),
                ],
              ),
            ),
            YMargin(30),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "GiftPose connects you to the gifts you need".tr(context),
                textAlign: TextAlign.center,

                style: GiftPoseTextStyle.large(fontWeight: FontWeight.w500),
              ),
            ),
            YMargin(60),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isAgreed = !_isAgreed;
                      });
                    },
                    child: Container(
                      width: 20.r,
                      height: 20.r,
                      decoration: BoxDecoration(
                        color: _isAgreed
                            ? GiftPoseColors.primaryColor
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(4.r),
                        border: Border.all(
                          color: _isAgreed
                              ? GiftPoseColors.primaryColor
                              : Colors.grey.shade400,
                          width: 1.5,
                        ),
                      ),
                      child: _isAgreed
                          ? Icon(
                              Icons.check,
                              size: 14.r,
                              color: Colors.white,
                            )
                          : null,
                    ),
                  ),
                  XMargin(10),
                  Flexible(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isAgreed = !_isAgreed;
                        });
                      },
                      child: RichText(
                        text: TextSpan(
                          style: GiftPoseTextStyle.medium(
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).textTheme.bodyMedium?.color,
                          ),
                          children: [
                            TextSpan(
                              text: "I agree to the ".tr(context),
                            ),
                            TextSpan(
                              text: "Terms of use and Code of Conduct.".tr(context),
                              style: TextStyle(
                                color: GiftPoseColors.primaryColor,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  final Uri url = Uri.parse('https://giftpose.com/terms-of-use');
                                  try {
                                    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
                                      await launchUrl(url);
                                    }
                                  } catch (e) {
                                    setState(() {
                                      _isAgreed = !_isAgreed;
                                    });
                                  }
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            YMargin(20),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: GiftPoseButton(
                title: "Continue".tr(context),
                isEnabled: _isAgreed,
                onTap: () {
                  HapticFeedback.heavyImpact();
                  Navigator.pushNamed(context, AppRoutes.consentPage);
                },
              ),
            ),
           
          
          ],
        );
      },
    );
  }
}
