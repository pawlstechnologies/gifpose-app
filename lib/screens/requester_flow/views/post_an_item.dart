import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
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
import 'package:giftpose/utils/widgets/giftpose_message_field.dart';
import 'package:giftpose/utils/widgets/giftpose_textfield.dart';
import 'package:provider/provider.dart';

class PostAnItemScreen extends StatelessWidget {
  const PostAnItemScreen({super.key, this.isEditing = false});

  final bool isEditing;

  static const _textColor = Color(0xFF181616);
  static const _inactiveRadioColor = Color(0xFF636366);

  @override
  Widget build(BuildContext context) {
    return GiftPoseBaseScaffold(
      showAppBar: false,
      includeHorizontalPadding: false,
      includeVerticalPadding: false,
      hasGradient: false,
      builder: (_) => Consumer<RequesterViewmodel>(
        builder: (context, vm, child) {
          return SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(9.w, 27.w, 11.w, 17.w),
            child: Column(
              children: [
                _buildHeader(context),
                SizedBox(height: (isEditing ? 40 : 25).w),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 11.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      isEditing
                          ? _buildEditImagePicker(context, vm)
                          : _buildImagePicker(context, vm),
                      if (vm.isAnalyzing) ...[
                        SizedBox(height: 12.w),
                        const LinearProgressIndicator(),
                      ],
                      if (!vm.isAnalyzing && vm.errorMessage != null) ...[
                        SizedBox(height: 12.w),
                        Text(
                          vm.errorMessage!,
                          style: GiftPoseTextStyle.small(
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                      ],
                      SizedBox(height: (isEditing ? 25 : 26).w),
                      GiftPoseTextField(
                        controller: vm.itemNameCtrl,
                        fieldName: 'Item Name'.tr(context),
                        hintText: 'Enter the item name'.tr(context),
                        height: 49,
                        scaleHeightByWidth: true,
                        borderRadius: 6,
                        hintFontSize: 12,
                        fieldNameFontSize: 12,
                        textFieldBottomPadding: 26,
                        textFieldColor: Theme.of(
                          context,
                        ).scaffoldBackgroundColor,
                        borderColor: GiftPoseColors.borderColor,
                      ),
                      GiftPoseMessageTextField(
                        controller: vm.itemDescriptionCtrl,
                        fieldName: 'Item Description'.tr(context),
                        hintText: 'Describe your item'.tr(context),
                        height: 140,
                        scaleHeightByWidth: true,
                        borderRadius: 6,
                        hintFontSize: 12,
                        fieldNameFontSize: 12,
                        textFieldBottomPadding: 26,
                        textFieldColor: Theme.of(
                          context,
                        ).scaffoldBackgroundColor,
                        borderColor: GiftPoseColors.borderColor,
                      ),
                      GiftPoseTextField(
                        controller: vm.locationCtrl,
                        fieldName: 'Enter location'.tr(context),
                        hintText: 'Input your location'.tr(context),
                        height: 49,
                        scaleHeightByWidth: true,
                        borderRadius: 6,
                        hintFontSize: 12,
                        fieldNameFontSize: 12,
                        textFieldBottomPadding: 26,
                        textFieldColor: Theme.of(
                          context,
                        ).scaffoldBackgroundColor,
                        borderColor: GiftPoseColors.borderColor,
                      ),
                      _buildPickupOptions(context, vm),
                      SizedBox(height: (isEditing ? 39 : 43).w),
                    ],
                  ),
                ),
                if (!isEditing)
                  Padding(
                    padding: EdgeInsets.only(right: 12.w),
                    child: GiftPoseButton(
                      title: 'Post'.tr(context),
                      height: 42,
                      scaleHeightByWidth: true,
                      borderRadius: 6,
                      onTap: vm.isSubmitting
                          ? null
                          : () async {
                              HapticFeedback.heavyImpact();
                              final success = await vm.submit();
                              if (!context.mounted) return;
                              if (success) {
                                Navigator.pushNamed(
                                  context,
                                  AppRoutes.requestPosted,
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      vm.errorMessage ?? 'Unable to post item',
                                    ),
                                  ),
                                );
                              }
                            },
                    ),
                  )
                else ...[
                  Padding(
                    padding: EdgeInsets.only(left: 8.w, right: 4.w),
                    child: GiftPoseButton(
                      title: 'Update'.tr(context),
                      height: 45,
                      scaleHeightByWidth: true,
                      borderRadius: 6,
                      onTap: vm.isSubmitting
                          ? null
                          : () async {
                              HapticFeedback.heavyImpact();
                              final success = await vm.submit(isEditing: true);
                              if (!context.mounted) return;
                              if (success) {
                                Navigator.pop(context);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      vm.errorMessage ??
                                          'Unable to update item',
                                    ),
                                  ),
                                );
                              }
                            },
                    ),
                  ),
                  SizedBox(height: 8.w),
                  Padding(
                    padding: EdgeInsets.only(left: 10.w, right: 4.w),
                    child: GiftPoseButton(
                      title: 'Cancel'.tr(context),
                      height: 49,
                      scaleHeightByWidth: true,
                      borderRadius: 6,
                      buttonType: GiftPoseButtonType.border,
                      backgroundColor: Colors.transparent,
                      borderColor: GiftPoseColors.borderColor,
                      textColor: Theme.of(context).textTheme.bodyLarge?.color,
                      onTap: () => Navigator.pop(context),
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return SizedBox(
      height: 31.w,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: InkWell(
              onTap: () {
                HapticFeedback.heavyImpact();
                Navigator.pop(context);
              },
              child: SizedBox(
                width: 24.w,
                height: 31.w,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Assets.icons.back.svg(
                    width: 12.w,
                    height: 24.w,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
              ),
            ),
          ),
          Text(
            (isEditing ? 'Edit Post' : 'Request an Item').tr(context),
            style: GiftPoseTextStyle.normal(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).brightness == Brightness.light
                  ? _textColor
                  : Theme.of(context).textTheme.bodyLarge?.color,
            ).copyWith(letterSpacing: 0.32),
          ),
        ],
      ),
    );
  }

  Widget _buildImagePicker(BuildContext context, RequesterViewmodel vm) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(text: '${'Reference Image'.tr(context)} '),
              TextSpan(
                text:
                    '(${"Upload any picture of what the item looks like".tr(context)})',
                style: const TextStyle(color: Color(0xFF857878)),
              ),
            ],
          ),
          style: GiftPoseTextStyle.normal(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).textTheme.bodyLarge?.color,
          ).copyWith(letterSpacing: 0.28),
        ),
        SizedBox(height: 20.w),
        DottedBorder(
          options: RoundedRectDottedBorderOptions(
            color: GiftPoseColors.primaryColor,
            strokeWidth: 2,
            dashPattern: const [7, 4],
            radius: const Radius.circular(24),
          ),
          child: InkWell(
            onTap: () {
              HapticFeedback.selectionClick();
              vm.pickReferenceImages();
            },
            borderRadius: BorderRadius.circular(24.r),
            child: SizedBox(
              width: double.infinity,
              height: 155.w,
              child: vm.referenceImages.isEmpty
                  ? _buildEmptyImageState(context)
                  : _buildSelectedImages(vm.referenceImages),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyImageState(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'assets/icons/requester/image_upload.svg',
          width: 24.w,
          height: 24.w,
        ),
        SizedBox(height: 9.w),
        Text(
          'Click here to upload your image'.tr(context),
          style: GiftPoseTextStyle.normal(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).textTheme.bodyLarge?.color,
          ).copyWith(letterSpacing: 0.28),
        ),
        SizedBox(height: 7.w),
        Text(
          'Up to 10 Images supported'.tr(context),
          style: GiftPoseTextStyle.small(
            color: Theme.of(
              context,
            ).textTheme.bodyLarge?.color?.withValues(alpha: 0.5),
          ),
        ),
      ],
    );
  }

  Widget _buildEditImagePicker(BuildContext context, RequesterViewmodel vm) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(text: '${'Reference Image'.tr(context)} '),
              TextSpan(
                text:
                    '(${"Upload any picture of what the item looks like".tr(context)})',
                style: const TextStyle(color: Color(0xFF857878)),
              ),
            ],
          ),
          style: GiftPoseTextStyle.normal(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).textTheme.bodyLarge?.color,
          ).copyWith(letterSpacing: 0.28),
        ),
        SizedBox(height: 20.w),
        Row(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(6.r),
                  child: vm.referenceImages.isNotEmpty
                      ? Image.file(
                          vm.referenceImages.first,
                          width: 130.w,
                          height: 100.w,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          'assets/images/requester/request_shoes.jpg',
                          width: 130.w,
                          height: 100.w,
                          fit: BoxFit.cover,
                        ),
                ),
                Positioned(
                  right: 7.w,
                  top: 9.w,
                  child: GestureDetector(
                    onTap: vm.referenceImages.isNotEmpty
                        ? () => vm.removeReferenceImage(0)
                        : null,
                    child: SvgPicture.asset(
                      'assets/icons/requester/cancel_image.svg',
                      width: 24.w,
                      height: 24.w,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: 35.w),
            InkWell(
              onTap: vm.pickReferenceImages,
              borderRadius: BorderRadius.circular(100.r),
              child: Container(
                width: 40.w,
                height: 40.w,
                decoration: const BoxDecoration(
                  color: Color(0xFFF1F1F1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.add,
                  size: 24.sp,
                  color: const Color(0xFF181616),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSelectedImages(List<File> images) {
    return GridView.builder(
      padding: EdgeInsets.all(12.w),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: images.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemBuilder: (context, index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(6.r),
          child: Image.file(images[index], fit: BoxFit.cover),
        );
      },
    );
  }

  Widget _buildPickupOptions(BuildContext context, RequesterViewmodel vm) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pickup-options'.tr(context),
          style: GiftPoseTextStyle.small(
            color: Theme.of(context).textTheme.bodyLarge?.color,
          ),
        ),
        SizedBox(height: 13.w),
        if (vm.isLoadingPickupOptions)
          const LinearProgressIndicator()
        else if (vm.pickupOptions.isEmpty)
          Text(
            vm.errorMessage ?? 'No pickup options available',
            style: GiftPoseTextStyle.small(
              color: Theme.of(context).colorScheme.error,
            ),
          )
        else
          Wrap(
            spacing: 32.w,
            runSpacing: 19.w,
            children: vm.pickupOptions
                .map((option) => _pickupOption(context, vm, option.name))
                .toList(),
          ),
      ],
    );
  }

  Widget _pickupOption(
    BuildContext context,
    RequesterViewmodel vm,
    String option,
  ) {
    final selected = vm.selectedPickupOption == option;
    return InkWell(
      onTap: () => vm.selectPickupOption(option),
      borderRadius: BorderRadius.circular(12.r),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 24.w,
            height: 24.w,
            child: Center(
              child: Container(
                width: 20.w,
                height: 20.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: selected
                        ? GiftPoseColors.primaryColor
                        : _inactiveRadioColor,
                    width: 2,
                  ),
                ),
                alignment: Alignment.center,
                child: selected
                    ? Container(
                        width: 10.w,
                        height: 10.w,
                        decoration: BoxDecoration(
                          color: GiftPoseColors.primaryColor,
                          shape: BoxShape.circle,
                        ),
                      )
                    : null,
              ),
            ),
          ),
          SizedBox(width: 7.w),
          Flexible(
            child: Text(
              option.tr(context),
              style: GiftPoseTextStyle.small(
                color: Theme.of(context).textTheme.bodyLarge?.color?.withValues(
                  alpha: selected ? 1 : 0.7,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
