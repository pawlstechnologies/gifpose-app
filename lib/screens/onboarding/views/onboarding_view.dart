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

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
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
      includeHorizontalPadding: false,
      includeVerticalPadding: false,
      showAppBar: false,
      hasGradient: true,

      builder: (size) {
        return Column(
          children: [
            Assets.images.splashImage.image(fit: BoxFit.contain),


            YMargin(50),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Assets.images.wave.image(height: 42.h,width: 33),
                  XMargin(15),
                  Text(
                    "Welcome",
                    style: GiftPoseTextStyle.heading1(
                      // The base color that will be gradient-masked
                    ),
                  ),
                ],
              ),
            ),
            YMargin(30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "GiftPose connects you to the gifts you need",
                    textAlign: TextAlign.center,
                
                style: GiftPoseTextStyle.large(fontWeight: FontWeight.w500),
              ),
            ),
            YMargin(30),
            Padding(
             padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit purus sit amet ",
                textAlign: TextAlign.center,
                style: GiftPoseTextStyle.medium(fontWeight: FontWeight.w500,         color: Theme.of(navigatorKey.currentContext!).textTheme.bodyMedium?.color),
              ),
            ),
              YMargin(18),
            Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GiftPoseButton(title: "Continue", onTap: (){
              HapticFeedback.selectionClick();
              Navigator.pushNamed(context,AppRoutes.consentPage);
              }),
            ),
          ],
        );
      },
    );
  }
}
