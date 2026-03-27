import 'package:flutter/material.dart';
import 'package:giftpose/utils/localization_provider.dart';

import 'package:giftpose/gen/assets.gen.dart';
import 'package:giftpose/utils/theme/giftpose_text_style.dart';
import 'package:giftpose/utils/theme/theme.dart';
import 'package:giftpose/utils/widgets/giftpose_button.dart';
import 'package:giftpose/utils/widgets/giftpose_message_field.dart';
import 'package:giftpose/utils/widgets/giftpose_textfield.dart';
import 'package:giftpose/utils/widgets/spacing.dart';

class NeedHelpBottomsheet extends StatelessWidget {
  NeedHelpBottomsheet({super.key});

  final fullNameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final subjectCtrl = TextEditingController();
  final messageCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox.shrink(),
            Text("Contact Support".tr(context),
              textAlign: TextAlign.center,

              style: GiftPoseTextStyle.small(
                color: Theme.of(context).textTheme.bodyLarge?.color,
                fontSize: 14,
              ),
            ),
            InkWell(
              onTap: () {
                HapticFeedback.heavyImpact();
                Navigator.pop(context);
              },
              child: Assets.icons.close.svg(),
            ),
          ],
        ),
        YMargin(14),
        Assets.icons.mail.svg(),
        YMargin(18),

        Text("""Have a question about your donation or need
technical help? Send us a message and we'll
get back to you within 24 hours.""".tr(context),
          textAlign: TextAlign.center,

          style: GiftPoseTextStyle.small(
            color: Theme.of(context).textTheme.bodyMedium?.color,
            fontSize: 14,
          ),
        ),
        YMargin(10),
        GiftPoseTextField(
          controller: fullNameCtrl,
          fieldName: "Full Name",

          hintText: "Enter your your full name",

          onChanged: (value) async {},
        ),
        GiftPoseTextField(
          controller: emailCtrl,
          fieldName: "Email Address",

          hintText: "Enter your your full name",

          onChanged: (value) async {},
        ),

        GiftPoseTextField(
          controller: subjectCtrl,
          fieldName: "Subject",
          suffixIcon: Assets.icons.down.svg(
            color: Theme.of(context).textTheme.bodyLarge?.color,
          ),

          hintText: "Select from the dropdown",

          onChanged: (value) async {},
        ),
        GiftPoseMessageTextField(
          controller: messageCtrl,
          fieldName: "  Message",

          hintText: "How can we help today?",

          onChanged: (value) async {},
        ),
        GiftPoseButton(title: "Send", onTap: () {}),
      ],
    );
  }
}
