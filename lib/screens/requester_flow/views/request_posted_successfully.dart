import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:giftpose/screens/requester_flow/viewmodels/requester_viewmodel.dart';
import 'package:giftpose/utils/localization_provider.dart';
import 'package:giftpose/utils/router/app_routes.dart';
import 'package:giftpose/utils/theme/giftpose_colors.dart';
import 'package:giftpose/utils/theme/giftpose_text_style.dart';
import 'package:giftpose/utils/widgets/Giftpose_basescafold.dart';
import 'package:giftpose/utils/widgets/giftpose_button.dart';
import 'package:provider/provider.dart';

class RequestPostedSuccessfullyScreen extends StatelessWidget {
  const RequestPostedSuccessfullyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GiftPoseBaseScaffold(
      showAppBar: false,
      includeHorizontalPadding: false,
      includeVerticalPadding: false,
      hasGradient: false,
      builder: (_) => Consumer<RequesterViewmodel>(
        builder: (context, vm, child) {
          return Column(
            children: [
              SizedBox(height: 24.w),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Column(
                  children: [
                    Text(
                      'Request Posted Successfully'.tr(context),
                      textAlign: TextAlign.center,
                      style: GiftPoseTextStyle.heading1(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ).copyWith(letterSpacing: 0.4),
                    ),
                    SizedBox(height: 8.w),
                    Text(
                      'Your request is now visible to people who can help. You’ll be notified when someone responds.'
                          .tr(context),
                      textAlign: TextAlign.center,
                      style: GiftPoseTextStyle.normal(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF857878),
                      ).copyWith(letterSpacing: 0.28),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 22.w),
              _RequestSummary(vm: vm),
              SizedBox(height: 33.w),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    GiftPoseButton(
                      title: 'View my Posting'.tr(context),
                      height: 49,
                      scaleHeightByWidth: true,
                      borderRadius: 6,
                      onTap: () {
                        HapticFeedback.selectionClick();
                        Navigator.pushReplacementNamed(
                          context,
                          AppRoutes.requestItemDetails,
                        );
                      },
                    ),
                    SizedBox(height: 21.w),
                    GiftPoseButton(
                      title: 'Go back to home'.tr(context),
                      height: 49,
                      scaleHeightByWidth: true,
                      borderRadius: 6,
                      buttonType: GiftPoseButtonType.border,
                      backgroundColor: Colors.transparent,
                      borderColor: GiftPoseColors.borderColor,
                      textColor: Theme.of(context).textTheme.bodyLarge?.color,
                      onTap: () {
                        HapticFeedback.selectionClick();
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          AppRoutes.dashboard,
                          (route) => false,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _RequestSummary extends StatelessWidget {
  const _RequestSummary({required this.vm});

  final RequesterViewmodel vm;

  @override
  Widget build(BuildContext context) {
    final itemName = vm.itemNameCtrl.text.trim().isEmpty
        ? 'Neatly Used Shoes'.tr(context)
        : vm.itemNameCtrl.text.trim();
    final location = vm.locationCtrl.text.trim().isEmpty
        ? 'United Kingdom'.tr(context)
        : vm.locationCtrl.text.trim();

    return Container(
      width: double.infinity,
      height: 73.w,
      padding: EdgeInsets.fromLTRB(22.w, 12.w, 16.w, 12.w),
      decoration: const BoxDecoration(
        color: Color(0xFFF6FFF5),
        border: Border(bottom: BorderSide(color: Color(0xFFDCFCE7))),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: _requestImage(vm.referenceImages),
          ),
          SizedBox(width: 36.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  itemName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GiftPoseTextStyle.normal(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ).copyWith(letterSpacing: 0.28),
                ),
                SizedBox(height: 8.w),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/requester/location.svg',
                      width: 20.w,
                      height: 20.w,
                      colorFilter: ColorFilter.mode(
                        GiftPoseColors.primaryColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        location,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GiftPoseTextStyle.small(
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF928F91),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _requestImage(List<File> images) {
    if (images.isNotEmpty) {
      return Image.file(
        images.first,
        width: 63.w,
        height: 48.w,
        fit: BoxFit.cover,
      );
    }
    return Image.asset(
      'assets/images/requester/request_item_example.jpg',
      width: 63.w,
      height: 48.w,
      fit: BoxFit.cover,
    );
  }
}
