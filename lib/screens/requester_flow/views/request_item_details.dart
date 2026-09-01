import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:giftpose/gen/assets.gen.dart';
import 'package:giftpose/screens/requester_flow/viewmodels/requester_viewmodel.dart';
import 'package:giftpose/utils/localization_provider.dart';
import 'package:giftpose/utils/router/app_routes.dart';
import 'package:giftpose/utils/theme/giftpose_colors.dart';
import 'package:giftpose/utils/theme/giftpose_text_style.dart';
import 'package:giftpose/utils/widgets/Giftpose_basescafold.dart';
import 'package:giftpose/utils/widgets/giftpose_button.dart';
import 'package:provider/provider.dart';

class RequestItemDetailsScreen extends StatelessWidget {
  const RequestItemDetailsScreen({super.key});

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
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(16.w, 27.w, 16.w, 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _header(context),
                      SizedBox(height: 25.w),
                      _heroImage(vm.referenceImages),
                      SizedBox(height: 21.w),
                      _itemHeading(context, vm),
                      SizedBox(height: 33.w),
                      _description(context, vm),
                      SizedBox(height: 19.w),
                      _description(context, vm),
                      SizedBox(height: 27.w),
                      _pickupCard(context),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(13.w, 0, 23.w, 13.w),
                child: Column(
                  children: [
                    GiftPoseButton(
                      title: 'Edit Post'.tr(context),
                      height: 49,
                      scaleHeightByWidth: true,
                      borderRadius: 6,
                      onTap: () {
                        HapticFeedback.selectionClick();
                        Navigator.pushNamed(context, AppRoutes.editRequestItem);
                      },
                    ),
                    SizedBox(height: 14.w),
                    GiftPoseButton(
                      title: 'Delete Post'.tr(context),
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

  Widget _header(BuildContext context) {
    return SizedBox(
      height: 31.w,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: InkWell(
              onTap: () => Navigator.pop(context),
              child: SizedBox(
                width: 12.w,
                height: 24.w,
                child: Assets.icons.back.svg(
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
            ),
          ),
          Text(
            'Item Offer Details'.tr(context),
            textAlign: TextAlign.center,
            style: GiftPoseTextStyle.normal(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ).copyWith(letterSpacing: 0.32),
          ),
        ],
      ),
    );
  }

  Widget _heroImage(List<File> images) {
    final Widget image = images.isNotEmpty
        ? Image.file(images.first, fit: BoxFit.cover)
        : Image.asset(
            'assets/images/requester/request_shoes.jpg',
            fit: BoxFit.cover,
          );
    return ClipRRect(
      borderRadius: BorderRadius.circular(6.r),
      child: SizedBox(width: 343.w, height: 277.w, child: image),
    );
  }

  Widget _itemHeading(BuildContext context, RequesterViewmodel vm) {
    final name = vm.itemNameCtrl.text.trim().isEmpty
        ? 'Neatly Used Shoes'.tr(context)
        : vm.itemNameCtrl.text.trim();
    final location = vm.locationCtrl.text.trim().isEmpty
        ? 'United Kingdom'.tr(context)
        : vm.locationCtrl.text.trim();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: GiftPoseTextStyle.normal(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ).copyWith(letterSpacing: 0.28),
              ),
              SizedBox(height: 10.w),
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
                  Text(
                    location,
                    style: GiftPoseTextStyle.small(
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF928F91),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () => Navigator.pushNamed(context, AppRoutes.requestOffers),
          child: Padding(
            padding: EdgeInsets.only(top: 1.w),
            child: Text(
              'View Offer (3)'.tr(context),
              style: GiftPoseTextStyle.small(color: GiftPoseColors.primaryColor)
                  .copyWith(
                    decoration: TextDecoration.underline,
                    decorationColor: GiftPoseColors.primaryColor,
                  ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _description(BuildContext context, RequesterViewmodel vm) {
    final description = vm.itemDescriptionCtrl.text.trim().isEmpty
        ? 'Lorem ipsum dolor sit amet, consectetur adipiscing elit purus sit amet purus sit amet Lorem ipsum dolor sit amet, consectetur adipiscing elit purus sit amet purus sit amet'
              .tr(context)
        : vm.itemDescriptionCtrl.text.trim();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.w),
      child: Text(
        description,
        style: GiftPoseTextStyle.small(
          color: const Color(0xFF857878),
        ).copyWith(height: 16 / 12),
      ),
    );
  }

  Widget _pickupCard(BuildContext context) {
    return Container(
      width: 343.w,
      height: 83.w,
      padding: EdgeInsets.fromLTRB(17.w, 6.w, 10.w, 9.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFF1F5F9)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Mode of Pickup'.tr(context),
            style: GiftPoseTextStyle.normal(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF0F172A),
            ).copyWith(letterSpacing: 0.28),
          ),
          SizedBox(height: 4.w),
          Row(
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: GiftPoseColors.primaryColor.withValues(alpha: 0.1),
                ),
                child: SvgPicture.asset(
                  'assets/icons/requester/pickup.svg',
                  width: 16.w,
                  height: 20.w,
                ),
              ),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pick-up'.tr(context),
                    style: GiftPoseTextStyle.small(
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1E293B),
                    ),
                  ),
                  Text(
                    'Agree on a public meeting point'.tr(context),
                    style: GiftPoseTextStyle.small(
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
