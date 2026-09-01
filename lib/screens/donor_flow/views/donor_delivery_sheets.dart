import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:giftpose/screens/donor_flow/viewmodels/donor_viewmodel.dart';
import 'package:giftpose/utils/theme/giftpose_colors.dart';
import 'package:giftpose/utils/theme/giftpose_text_style.dart';
import 'package:giftpose/utils/widgets/giftpose_button.dart';
import 'package:provider/provider.dart';

Future<void> showConfirmGiftDelivery(BuildContext context) async {
  await _sheet(
    context,
    height: 362,
    child: Column(
      children: [
        _close(context),
        CircleAvatar(
          radius: 40.r,
          backgroundColor: const Color(0xFFF2FFF4),
          child: const Icon(
            Icons.handshake_outlined,
            color: Color(0xFF00D64F),
            size: 30,
          ),
        ),
        SizedBox(height: 14.w),
        Text(
          'Confirm Gift Delivery',
          style: GiftPoseTextStyle.normal(fontSize: 14),
        ),
        SizedBox(height: 9.w),
        Text(
          'The recipient reported that the gift arrived.\nConfirm to finalize',
          textAlign: TextAlign.center,
          style: GiftPoseTextStyle.normal(
            fontSize: 14,
            color: const Color(0xFF8B8181),
          ),
        ),
        const Spacer(),
        GiftPoseButton(
          title: 'Yes,',
          height: 49,
          scaleHeightByWidth: true,
          onTap: () {
            Navigator.pop(context);
            showThanksForConfirming(context);
          },
        ),
        SizedBox(height: 12.w),
        GiftPoseButton(
          title: 'Not Yet',
          height: 49,
          scaleHeightByWidth: true,
          buttonType: GiftPoseButtonType.border,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          borderColor: GiftPoseColors.borderColor,
          textColor: Theme.of(context).textTheme.bodyLarge?.color,
          onTap: () => Navigator.pop(context),
        ),
      ],
    ),
  );
}

Future<void> showThanksForConfirming(BuildContext context) async {
  await _sheet(
    context,
    height: 326,
    child: Column(
      children: [
        _close(context),
        const Spacer(),
        Text(
          'Thank you for Confirming',
          style: GiftPoseTextStyle.normal(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 17.w),
        Text(
          'Thank you for using our platform. Your\nfeedback helps the community grow and\nstay safe.',
          textAlign: TextAlign.center,
          style: GiftPoseTextStyle.normal(
            fontSize: 14,
            color: const Color(0xFF667085),
          ),
        ),
        const Spacer(),
        GiftPoseButton(
          title: 'Rate Receiver',
          height: 45,
          scaleHeightByWidth: true,
          onTap: () {
            Navigator.pop(context);
            showRateReceiver(context);
          },
        ),
      ],
    ),
  );
}

Future<void> showRateReceiver(BuildContext context) async {
  final vm = context.read<DonorViewmodel>();
  await _sheet(
    context,
    height: 586,
    child: StatefulBuilder(
      builder: (context, setState) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Text(
                'Rate your experience',
                style: GiftPoseTextStyle.normal(fontSize: 14),
              ),
              const Spacer(),
              InkWell(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.close, color: Color(0xFF64748B)),
              ),
            ],
          ),
          SizedBox(height: 22.w),
          Center(
            child: Text(
              'How would you rate the donor?',
              style: GiftPoseTextStyle.normal(
                fontSize: 16,
                color: const Color(0xFF667085),
              ),
            ),
          ),
          SizedBox(height: 14.w),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              5,
              (i) => IconButton(
                onPressed: () {
                  vm.setRating(i + 1);
                  setState(() {});
                },
                icon: Icon(
                  i < vm.selectedRating ? Icons.star : Icons.star_border,
                  size: 32,
                  color: i < vm.selectedRating
                      ? const Color(0xFFFFC107)
                      : const Color(0xFFD7DADF),
                ),
              ),
            ),
          ),
          SizedBox(height: 12.w),
          Text(
            'Write your review',
            style: GiftPoseTextStyle.normal(fontSize: 14),
          ),
          SizedBox(height: 10.w),
          TextField(
            controller: vm.reviewController,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: 'How will you describe your experience with the donor',
              border: OutlineInputBorder(
                borderSide: BorderSide(color: GiftPoseColors.borderColor),
                borderRadius: BorderRadius.circular(6.r),
              ),
            ),
          ),
          SizedBox(height: 18.w),
          Container(
            height: 73.w,
            padding: EdgeInsets.all(15.w),
            decoration: BoxDecoration(
              color: const Color(0xFFF1FBF9),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: const Color(0xFFCDECE6)),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.verified_user_outlined,
                  color: Color(0xFF00B989),
                ),
                SizedBox(width: 11.w),
                Expanded(
                  child: Text(
                    'Your feedback helps verify donors and\nstrengthens our community trust.',
                    style: GiftPoseTextStyle.small(
                      color: const Color(0xFF475569),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          GiftPoseButton(
            title: 'Submit',
            height: 49,
            scaleHeightByWidth: true,
            onTap: () {
              Navigator.pop(context);
              showFeedbackThanks(context);
            },
          ),
          SizedBox(height: 18.w),
          GiftPoseButton(
            title: 'Cancel',
            height: 49,
            scaleHeightByWidth: true,
            buttonType: GiftPoseButtonType.border,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            borderColor: GiftPoseColors.borderColor,
            textColor: Theme.of(context).textTheme.bodyLarge?.color,
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    ),
  );
}

Future<void> showFeedbackThanks(BuildContext context) async {
  await _sheet(
    context,
    height: 328,
    child: Column(
      children: [
        _close(context),
        const Spacer(),
        Text(
          'Thank you for your Feedback',
          style: GiftPoseTextStyle.normal(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 17.w),
        Text(
          'Your review helps in making the community safe\nand trusted',
          textAlign: TextAlign.center,
          style: GiftPoseTextStyle.normal(
            fontSize: 14,
            color: const Color(0xFF8B8181),
          ),
        ),
        const Spacer(),
        GiftPoseButton(
          title: 'Go back home',
          height: 45,
          scaleHeightByWidth: true,
          onTap: () => Navigator.popUntil(context, (route) => route.isFirst),
        ),
      ],
    ),
  );
}

Widget _close(BuildContext context) => Align(
  alignment: Alignment.centerRight,
  child: InkWell(
    onTap: () => Navigator.pop(context),
    child: const Icon(Icons.close, color: Color(0xFF64748B)),
  ),
);

Future<void> _sheet(
  BuildContext context, {
  required double height,
  required Widget child,
}) => showModalBottomSheet<void>(
  context: context,
  isScrollControlled: true,
  backgroundColor: Colors.transparent,
  builder: (_) => Container(
    height: height.w,
    padding: EdgeInsets.fromLTRB(16.w, 27.w, 16.w, 30.w),
    decoration: BoxDecoration(
      color: Theme.of(context).scaffoldBackgroundColor,
      borderRadius: BorderRadius.vertical(top: Radius.circular(18.r)),
    ),
    child: child,
  ),
);
