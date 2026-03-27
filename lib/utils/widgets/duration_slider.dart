import 'package:flutter/material.dart';
import 'package:giftpose/utils/localization_provider.dart';

import 'package:giftpose/screens/onboarding/viewmodels/onboarding_viewmodel.dart';
import 'package:giftpose/utils/theme/giftpose_colors.dart';
import 'package:provider/provider.dart';

class DurationSlider extends StatefulWidget {
  final Function(double)? onChanged;

  DurationSlider({super.key, this.onChanged});

  @override
  State<DurationSlider> createState() => _DurationSliderState();
}

class _DurationSliderState extends State<DurationSlider> {
  @override
  Widget build(BuildContext context) {
    return Consumer<OnboardingViewModel>(
      builder: (context, onboardVm, child) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            /// 🔥 CURRENT MILES DISPLAY
            Text("${onboardVm.miles.toStringAsFixed(0)} miles".tr(context),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: GiftPoseColors.primaryColor,
              ),
            ),

            SizedBox(height: 10),

            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 4,
                activeTrackColor: GiftPoseColors.primaryColor,
                inactiveTrackColor: GiftPoseColors.textColor2,
                thumbColor: GiftPoseColors.primaryColor,
                overlayColor: GiftPoseColors.primaryColor.withOpacity(0.2),
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8),
              ),
              child: Slider(
                min: 1,
                max: 50,
                divisions: 49,
                value: onboardVm.miles,
                onChanged: (value) {
                  onboardVm.updateMiles(value);
                  widget.onChanged?.call(value);
                },
              ),
            ),

            SizedBox(height: 8),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("1mi".tr(context), style: TextStyle(color: Colors.grey)),
                Text("25mi".tr(context), style: TextStyle(color: Colors.grey)),
                Text("50mi".tr(context), style: TextStyle(color: Colors.grey)),
              ],
            )
          ],
        );
      },
    );
  }
}