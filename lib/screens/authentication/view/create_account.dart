import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:giftpose/app.dart';
import 'package:giftpose/gen/assets.gen.dart';
import 'package:giftpose/utils/router/app_routes.dart';
import 'package:giftpose/utils/theme/giftpose_text_style.dart';
import 'package:giftpose/utils/theme/theme.dart';
import 'package:giftpose/utils/widgets/Giftpose_basescafold.dart';
import 'package:giftpose/utils/widgets/giftpose_button.dart';
import 'package:giftpose/utils/widgets/giftpose_textfield.dart';
import 'package:giftpose/utils/widgets/spacing.dart';
import 'package:provider/provider.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen>
    with SingleTickerProviderStateMixin {
   final fullnameCtrl = TextEditingController();
     final emailCtrl = TextEditingController();
       final passwordCtrl = TextEditingController();
         final usernameCtrl = TextEditingController();
   final confirmPasswordCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
              "Create an Account",
              style: GiftPoseTextStyle.heading1(fontWeight: FontWeight.w500),
            ),
            YMargin(26),

     GiftPoseTextField(controller:fullnameCtrl, hintText: "Enter your full name",),
           

            YMargin(18),

            GiftPoseButton(
              title: "Give Consent",
              onTap: () {
                HapticFeedback.selectionClick();
                Navigator.pushNamed(context, AppRoutes.postcodePage);

              },
            ),
          ],
        );
      },
    );
  }
}
