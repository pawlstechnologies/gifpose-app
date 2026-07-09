import 'package:flutter/material.dart';
import 'package:giftpose/screens/authentication/viewmodel/authentication_viewmodel.dart';
import 'package:flutter/services.dart';
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
import 'package:giftpose/utils/widgets/giftpose_otp_inputfield.dart';
import 'package:giftpose/utils/widgets/giftpose_textfield.dart';
import 'package:giftpose/utils/widgets/spacing.dart';
import 'package:provider/provider.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticationViewModel>(
      builder: (context, vm, child) {
        return GiftPoseBaseScaffold(
          showAppBar: false,
          hasGradient: true,

          builder: (size) {
            return Column(
              children: [
                YMargin(40),
                Assets.images.logo.image(height: 40, width: 40),
                YMargin(26),
                Text(
                  "Enter Code".tr(context),
                  style: GiftPoseTextStyle.heading1(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                YMargin(26),

                GiftPoseOtpInputField(
                  controller: vm.otpCtrl,
                  length: 6,
                  // Optionally customize colors:
                  backgroundColor: const Color(0xFF6E6E8E),
                  dotColor: Theme.of(context).textTheme.bodyLarge!.color,
                  emptyDotColor: Theme.of(context).textTheme.bodyMedium!.color,
                ),
YMargin(30),
                GiftPoseButton(
                  title: "Send Code".tr(context),
                  onTap: () {
                    HapticFeedback.heavyImpact();
                    vm.verifyEmailAddress();
                  },
                ),
                YMargin(27),
                InkWell(
                  onTap: () {
                    HapticFeedback.heavyImpact();
                    vm.resendOtp();
                  },  
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Send code again:".tr(context),
                        style: GiftPoseTextStyle.medium(
                          color: GiftPoseColors.primaryColor,
                          fontSize: 14,
                        ),
                      ),
                      TweenAnimationBuilder<Duration>(
                        duration: const Duration(seconds: 30),
                        tween: Tween(
                          begin: const Duration(seconds: 30),
                          end: Duration.zero,
                        ),
                        builder: (context, value, child) {
                          final seconds = value.inSeconds;
                          return Text(
                            " 00:${seconds.toString().padLeft(2, '0')}",
                            style: GiftPoseTextStyle.medium(
                              color: GiftPoseColors.primaryColor,
                              fontSize: 14,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
