import 'package:flutter/material.dart';
import 'package:giftpose/screens/onboarding/viewmodels/onboarding_viewmodel.dart';
import 'package:giftpose/utils/theme/giftpose_colors.dart';
import 'package:provider/provider.dart';

class DurationSlider extends StatefulWidget {
  final Function(double)? onChanged;

  const DurationSlider({super.key, this.onChanged});

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
            Text(
              "${onboardVm.miles.toStringAsFixed(0)} miles",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: GiftPoseColors.primaryColor,
              ),
            ),

            const SizedBox(height: 10),

            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 4,
                activeTrackColor: GiftPoseColors.primaryColor,
                inactiveTrackColor: GiftPoseColors.textColor2,
                thumbColor: GiftPoseColors.primaryColor,
                overlayColor: GiftPoseColors.primaryColor.withOpacity(0.2),
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
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

            const SizedBox(height: 8),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("1mi", style: TextStyle(color: Colors.grey)),
                Text("25mi", style: TextStyle(color: Colors.grey)),
                Text("50mi", style: TextStyle(color: Colors.grey)),
              ],
            )
          ],
        );
      },
    );
  }
}