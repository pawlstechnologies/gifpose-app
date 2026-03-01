import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:giftpose/app.dart';
import 'package:giftpose/gen/assets.gen.dart';
import 'package:giftpose/utils/router/app_routes.dart';
import 'package:giftpose/utils/theme/giftpose_colors.dart';
import 'package:giftpose/utils/theme/giftpose_text_style.dart';
import 'package:giftpose/utils/theme/theme.dart';
import 'package:giftpose/utils/widgets/Giftpose_basescafold.dart';
import 'package:giftpose/utils/widgets/duration_slider.dart';
import 'package:giftpose/utils/widgets/giftpose_button.dart';
import 'package:giftpose/utils/widgets/giftpose_textfield.dart';
import 'package:giftpose/utils/widgets/spacing.dart';
import 'package:provider/provider.dart';

class PostcodeScreen extends StatefulWidget {
  const PostcodeScreen({super.key});

  @override
  State<PostcodeScreen> createState() => _PostcodeScreenState();
}

class _PostcodeScreenState extends State<PostcodeScreen>
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
  final postcodeCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GiftPoseBaseScaffold(
      includeHorizontalPadding:true,
      includeVerticalPadding: false,

      showAppBar: true,
      hasGradient: false,
      appBarLeadingWidget: Assets.icons.back.svg(
        color: GiftPoseColors.background,
      ),
      appBarTitleWidget: Text(
        "Set Location",
        textAlign: TextAlign.center,

        style: GiftPoseTextStyle.large(fontWeight: FontWeight.w500),
      ),
      centerTitle: true,

      builder: (size) {
        return Column(
          children: [
            YMargin(50),
            GiftPoseTextField(controller: postcodeCtrl, hintText: "Enter your postcode",prefixIcon: Assets.icons.search.svg(),),
            Assets.images.map.image(height: 282, width: 343),

            YMargin(26),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "How far are you willing to travel?",
                textAlign: TextAlign.center,

                style: GiftPoseTextStyle.medium(fontWeight: FontWeight.w500),
              ),
            ),
            YMargin(14),
            DurationSlider(),
            YMargin(32),

            GiftPoseButton(title: "Submit", onTap: () {
              HapticFeedback.selectionClick();
              Navigator.pushNamed(context, AppRoutes.loaderPage);
            }),
          ],
        );
      },
    );
  }
}
