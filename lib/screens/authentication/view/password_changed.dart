import 'package:flutter/material.dart';
import 'package:giftpose/screens/authentication/viewmodel/authentication_viewmodel.dart';
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
import 'package:giftpose/utils/widgets/giftpose_textfield.dart';
import 'package:giftpose/utils/widgets/spacing.dart';
import 'package:provider/provider.dart';

class PasswordChangedScreen extends StatelessWidget {
  const PasswordChangedScreen({super.key});

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
                 YMargin(400),
              
               
                      Text("Password Changed".tr(context),
                        style: GiftPoseTextStyle.heading1(fontWeight: FontWeight.w500),
                      ),
           Text("Your password has been updated successfully. Please log in with your new password.".tr(context),
                        style: GiftPoseTextStyle.medium(fontWeight: FontWeight.w500, color: Theme.of(context).textTheme.bodyMedium!.color),
                      ),
                      YMargin(30),
             GiftPoseButton(
                  title: "Send Code".tr(context),
                  onTap: () {
                    HapticFeedback.heavyImpact();
                   vm.forgotPassword();
        
                  },
                ),
                     YMargin(27),



              ],
            );
          },
        );
      }
    );
  }
}
