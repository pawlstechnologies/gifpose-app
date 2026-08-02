import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:giftpose/screens/authentication/viewmodel/authentication_viewmodel.dart';
import 'package:giftpose/utils/localization_provider.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:giftpose/app.dart';
import 'package:giftpose/gen/assets.gen.dart';
import 'package:giftpose/utils/router/app_routes.dart';
import 'package:giftpose/utils/theme/giftpose_colors.dart';
import 'package:giftpose/utils/theme/giftpose_text_style.dart';
import 'package:giftpose/utils/theme/theme.dart';
import 'package:giftpose/utils/validators.dart';
import 'package:giftpose/utils/widgets/Giftpose_basescafold.dart';
import 'package:giftpose/utils/widgets/giftpose_button.dart';
import 'package:giftpose/utils/widgets/giftpose_textfield.dart';
import 'package:giftpose/utils/widgets/spacing.dart';
import 'package:provider/provider.dart';

class SigininScreen extends StatelessWidget with Validators {
  SigininScreen({super.key});
final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticationViewModel>(
      builder: (context, vm, child) {
        final canPop = Navigator.canPop(context);

        return PopScope(
          canPop: canPop,
          onPopInvokedWithResult: (didPop, result) {
            if (!didPop) {
              Navigator.pushReplacementNamed(
                context,
                AppRoutes.dashboard,
              );
            }
          },
          child: GiftPoseBaseScaffold(
            showAppBar: false,
            hasGradient: true,

            builder: (size) {
              return Column(
                children: [
                  YMargin(16),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: () {
                        HapticFeedback.heavyImpact();
                        if (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        } else {
                          Navigator.pushReplacementNamed(
                            context,
                            AppRoutes.dashboard,
                          );
                        }
                      },
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: Center(
                        child: Assets.icons.back.svg(
                          colorFilter: ColorFilter.mode(
                            Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                YMargin(16),
                Assets.images.logo.image(height: 40, width: 40),
                YMargin(26),
                Text(
                  "Welcome Back".tr(context),
                  style: GiftPoseTextStyle.heading1(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                YMargin(26),

                GiftPoseTextField(
                  controller: vm.emailCtrl,
                  hintText: "Enter your email".tr(context),
                  fieldName: "Email".tr(context),
        
                 
                ),
                GiftPoseTextField(
                  controller: vm.passwordCtrl,
                  hintText: "password".tr(context),
                  fieldName: "Password".tr(context),
                  obscureText: vm.obscureText2,
                  suffixIcon: IconButton(
                    onPressed: () {
                      vm.updateObscureText2();
                    },
                    icon: Icon(
                      vm.obscureText2 ? Icons.visibility : Icons.visibility_off,
                    ),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        HapticFeedback.heavyImpact();
                        Navigator.pushNamed(
                          context,
                          AppRoutes.forgotPasswordScreen,
                        );
                      },
                      child: Text(
                        "Forgot Password".tr(context),
                        style: GiftPoseTextStyle.medium(
                          color: GiftPoseColors.primaryColor,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                YMargin(18),

                GiftPoseButton(
                  title: "Log In".tr(context),
                  onTap: () {
                    HapticFeedback.heavyImpact();
                    vm.signIn();
                  },
                ),
                YMargin(27),
                Row(
                  children: [
                    Expanded(
                      child: Divider(color: Theme.of(context).dividerColor),
                    ),
                    XMargin(10),
                    Text(
                      "Or Sign In with".tr(context),
                      style: GiftPoseTextStyle.medium(
                        fontSize: 14,
                        color: Theme.of(context).textTheme.bodyMedium!.color,
                      ),
                    ),
                    XMargin(10),
                    Expanded(
                      child: Divider(color: Theme.of(context).dividerColor),
                    ),
                  ],
                ),
                YMargin(35),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 42.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Assets.icons.ex.svg(),
                      Assets.images.facebook.image(height: 47, width: 47),
                      Assets.icons.apple.svg(),
                      Assets.images.google.image(height: 47, width: 47),
                    ],
                  ),
                ),
                YMargin(35),
                InkWell(
                  onTap: () {
                    HapticFeedback.heavyImpact();
                    Navigator.pushNamed(
                      context,
                      AppRoutes.createAccountPage,
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?".tr(context),
                        style: GiftPoseTextStyle.medium(
                          color: Theme.of(context).textTheme.bodyMedium!.color,
                          fontSize: 14,
                        ),
                      ),
                      XMargin(8),
                      Text(
                        "Sign Up".tr(context),
                        style: GiftPoseTextStyle.medium(
                          fontSize: 14,
                          color: GiftPoseColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      );
    },
  );
  }
}
