import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:giftpose/app.dart';
import 'package:giftpose/gen/assets.gen.dart';
import 'package:giftpose/utils/router/app_routes.dart';
import 'package:giftpose/utils/theme/giftpose_text_style.dart';
import 'package:giftpose/utils/theme/theme.dart';
import 'package:giftpose/utils/widgets/Giftpose_basescafold.dart';
import 'package:giftpose/utils/widgets/giftpose_button.dart';
import 'package:giftpose/utils/widgets/spacing.dart';
import 'package:provider/provider.dart';

class ConsentScreen extends StatefulWidget {
  const ConsentScreen({super.key});

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
      showAppBar: false,
      hasGradient: true,

      builder: (size) {
        return Column(
          children: [
            YMargin(196),
            Assets.icons.checklist.svg(),
            YMargin(30),
            Text(
              "GiftPose asks for your consent to use your personal data to:",
              style: GiftPoseTextStyle.heading1(fontWeight: FontWeight.w500),
            ),
            YMargin(16),

            Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit purus sit amet ",
              textAlign: TextAlign.center,

              style: GiftPoseTextStyle.medium(fontWeight: FontWeight.w500,color: Theme.of(navigatorKey.currentContext!).textTheme.bodyMedium?.color),
            ),

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
