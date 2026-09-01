import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:giftpose/screens/donor_flow/viewmodels/donor_viewmodel.dart';
import 'package:giftpose/screens/donor_flow/widgets/donor_widgets.dart';
import 'package:giftpose/utils/router/app_routes.dart';
import 'package:giftpose/utils/theme/giftpose_colors.dart';
import 'package:giftpose/utils/theme/giftpose_text_style.dart';
import 'package:giftpose/utils/widgets/Giftpose_basescafold.dart';
import 'package:giftpose/utils/widgets/giftpose_button.dart';
import 'package:giftpose/utils/widgets/giftpose_message_field.dart';
import 'package:giftpose/utils/widgets/giftpose_textfield.dart';
import 'package:provider/provider.dart';

class DonorPostItemScreen extends StatelessWidget {
  const DonorPostItemScreen({
    super.key,
    this.offeringRequestedItem = false,
    this.isEditing = false,
  });

  final bool offeringRequestedItem;
  final bool isEditing;

  @override
  Widget build(BuildContext context) {
    return GiftPoseBaseScaffold(
      showAppBar: false,
      includeHorizontalPadding: false,
      includeVerticalPadding: false,
      hasGradient: false,
      builder: (_) => Consumer<DonorViewmodel>(
        builder: (context, vm, child) {
          if (isEditing || vm.postStep == DonorPostStep.review) {
            return _DonorReviewPost(
              offeringRequestedItem: offeringRequestedItem,
              editing: isEditing,
            );
          }
          return SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(16.w, 27.w, 16.w, 60.w),
            child: Column(
              children: [
                DonorHeader(
                  title: offeringRequestedItem
                      ? 'Post the Item to Offer'
                      : 'Post an Item',
                ),
                SizedBox(height: 8.w),
                if (vm.postStep == DonorPostStep.compose) ...[
                  Container(
                    width: 329.w,
                    height: 46.w,
                    color: const Color(0xFFFFFCF5),
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.auto_awesome,
                          color: Color(0xFFFFBA24),
                          size: 20,
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Text(
                            'Upload an Image(s) and we will automatically fill in details for you',
                            style: GiftPoseTextStyle.small(
                              color: Theme.of(
                                context,
                              ).textTheme.bodyLarge?.color,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 25.w),
                  SizedBox(
                    width: 329.w,
                    child: DottedBorder(
                      options: RoundedRectDottedBorderOptions(
                        color: GiftPoseColors.primaryColor,
                        strokeWidth: 2,
                        dashPattern: const [7, 4],
                        radius: const Radius.circular(24),
                      ),
                      child: InkWell(
                        onTap: vm.pickImage,
                        child: SizedBox(
                          width: double.infinity,
                          height: 155.w,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/icons/requester/image_upload.svg',
                                width: 24.w,
                                height: 24.w,
                              ),
                              SizedBox(height: 9.w),
                              Text(
                                'Click here to upload your image',
                                style: GiftPoseTextStyle.normal(fontSize: 14),
                              ),
                              SizedBox(height: 7.w),
                              Text(
                                'Up to 10 Images supported',
                                style: GiftPoseTextStyle.small(
                                  color: const Color(0xFF9A9494),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 29.w),
                ] else ...[
                  SizedBox(height: 17.w),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: _SelectedImage(
                      image: vm.selectedImage,
                      onRemove: vm.removeImage,
                    ),
                  ),
                  SizedBox(height: 20.w),
                  Container(
                    width: 330.w,
                    height: 49.w,
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF6FFF5),
                      borderRadius: BorderRadius.circular(10.r),
                      border: const Border(
                        bottom: BorderSide(color: Color(0xFF63E66A)),
                      ),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 18.w,
                          height: 18.w,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: GiftPoseColors.primaryColor,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Text(
                          'Analyzing Image......',
                          style: GiftPoseTextStyle.small(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 25.w),
                ],
                if (vm.errorMessage != null) ...[
                  Text(
                    vm.errorMessage!,
                    style: GiftPoseTextStyle.small(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                  SizedBox(height: 12.w),
                ],
                GiftPoseTextField(
                  controller: vm.itemNameController,
                  fieldName: 'Item Name',
                  hintText: 'Enter the item name',
                  height: 49,
                  scaleHeightByWidth: true,
                  borderRadius: 6,
                  hintFontSize: 12,
                  fieldNameFontSize: 12,
                  textFieldBottomPadding: 26,
                  borderColor: GiftPoseColors.borderColor,
                  textFieldColor: Theme.of(context).scaffoldBackgroundColor,
                ),
                GiftPoseMessageTextField(
                  controller: vm.descriptionController,
                  fieldName: 'Item Description',
                  hintText: 'Describe your item',
                  height: 140,
                  scaleHeightByWidth: true,
                  borderRadius: 6,
                  hintFontSize: 12,
                  fieldNameFontSize: 12,
                  textFieldBottomPadding: 0,
                  borderColor: GiftPoseColors.borderColor,
                  textFieldColor: Theme.of(context).scaffoldBackgroundColor,
                ),
                SizedBox(
                  height: vm.postStep == DonorPostStep.compose ? 163.w : 100.w,
                ),
                GiftPoseButton(
                  title: 'Post',
                  height: 49,
                  scaleHeightByWidth: true,
                  onTap: vm.showReview,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _SelectedImage extends StatelessWidget {
  const _SelectedImage({required this.image, required this.onRemove});

  final File? image;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: image == null
                  ? Image.asset(
                      'assets/images/requester/request_item_example.jpg',
                      width: 139.w,
                      height: 103.w,
                      fit: BoxFit.cover,
                    )
                  : Image.file(
                      image!,
                      width: 139.w,
                      height: 103.w,
                      fit: BoxFit.cover,
                    ),
            ),
            Positioned(
              right: 5.w,
              top: 5.w,
              child: InkWell(
                onTap: onRemove,
                child: const CircleAvatar(
                  radius: 10,
                  backgroundColor: Colors.black,
                  child: Icon(Icons.close, color: Colors.white, size: 14),
                ),
              ),
            ),
          ],
        ),
        SizedBox(width: 35.w),
        InkWell(
          onTap: () {},
          child: CircleAvatar(
            radius: 20.r,
            backgroundColor: const Color(0xFFF1F1F1),
            child: const Icon(Icons.add, color: Color(0xFF181616)),
          ),
        ),
      ],
    );
  }
}

class _DonorReviewPost extends StatelessWidget {
  const _DonorReviewPost({
    required this.offeringRequestedItem,
    this.editing = false,
  });

  final bool offeringRequestedItem;
  final bool editing;

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<DonorViewmodel>();
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(16.w, 27.w, 16.w, 51.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DonorHeader(title: editing ? 'Edit Post' : 'Review the Post'),
          SizedBox(height: 40.w),
          _SelectedImage(image: vm.selectedImage, onRemove: vm.removeImage),
          SizedBox(height: 38.w),
          GiftPoseTextField(
            controller: vm.itemNameController,
            fieldName: 'Item Name',
            height: 49,
            scaleHeightByWidth: true,
            borderRadius: 6,
            fieldNameFontSize: 12,
            textFieldBottomPadding: 26,
            borderColor: GiftPoseColors.borderColor,
          ),
          GiftPoseMessageTextField(
            controller: vm.descriptionController,
            fieldName: 'Item Description',
            height: 123,
            scaleHeightByWidth: true,
            borderRadius: 6,
            fieldNameFontSize: 12,
            textFieldBottomPadding: 25,
            borderColor: GiftPoseColors.borderColor,
          ),
          _ReviewRow(
            label: 'Category',
            value: vm.category,
            onTap: () =>
                Navigator.pushNamed(context, AppRoutes.donorEditCategory),
          ),
          SizedBox(height: 27.w),
          Text(
            'Pickup Location',
            style: GiftPoseTextStyle.normal(fontSize: 14),
          ),
          SizedBox(height: 16.w),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 44.w,
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                decoration: BoxDecoration(
                  color: const Color(0xFFF4F4F4),
                  borderRadius: BorderRadius.circular(22.r),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      color: Color(0xFF8C7D7D),
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      vm.location,
                      style: GiftPoseTextStyle.normal(
                        fontSize: 14,
                        color: const Color(0xFF6E6262),
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () =>
                    Navigator.pushNamed(context, AppRoutes.donorEditLocation),
                child: Text(
                  'Edit',
                  style: GiftPoseTextStyle.normal(
                    fontSize: 14,
                    color: GiftPoseColors.primaryColor,
                  ).copyWith(decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
          if (offeringRequestedItem || editing) ...[
            SizedBox(height: 16.w),
            const Divider(),
            SizedBox(height: 16.w),
            Text(
              'Pickup-options',
              style: GiftPoseTextStyle.normal(fontSize: 14),
            ),
            SizedBox(height: 14.w),
            _pickupOptions(vm),
          ],
          SizedBox(height: offeringRequestedItem || editing ? 25.w : 75.w),
          GiftPoseButton(
            title: editing
                ? 'Save Changes'
                : offeringRequestedItem
                ? 'Submit'
                : 'Confirm',
            height: 49,
            scaleHeightByWidth: true,
            onTap: vm.isSubmitting
                ? null
                : () async {
                    final success = await vm.submit(
                      isEditing: editing,
                      offeringRequestedItem: offeringRequestedItem,
                    );
                    if (!context.mounted) return;
                    if (!success) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            vm.errorMessage ?? 'Unable to save item',
                          ),
                        ),
                      );
                      return;
                    }
                    if (editing) {
                      Navigator.pop(context);
                    } else {
                      Navigator.pushReplacementNamed(
                        context,
                        offeringRequestedItem
                            ? AppRoutes.donorOfferSuccess
                            : AppRoutes.donorPostedSuccess,
                      );
                    }
                  },
          ),
        ],
      ),
    );
  }

  Widget _pickupOptions(DonorViewmodel vm) {
    if (vm.isLoadingPickupOptions) return const LinearProgressIndicator();
    if (vm.pickupOptions.isEmpty) {
      return Text(vm.errorMessage ?? 'No pickup options available');
    }
    return Wrap(
      spacing: 20.w,
      runSpacing: 16.w,
      children: vm.pickupOptions
          .map(
            (option) => _RadioLabel(
              label: option.name,
              selected: vm.selectedPickupOption == option.name,
              onTap: () => vm.selectPickupOption(option.name),
            ),
          )
          .toList(),
    );
  }
}

class _ReviewRow extends StatelessWidget {
  const _ReviewRow({
    required this.label,
    required this.value,
    required this.onTap,
  });
  final String label;
  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GiftPoseTextStyle.normal(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 13.w),
          Row(
            children: [
              Expanded(
                child: Text(
                  value,
                  style: GiftPoseTextStyle.normal(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF6E6262),
                  ),
                ),
              ),
              const Icon(Icons.chevron_right, color: Color(0xFF999999)),
            ],
          ),
          SizedBox(height: 12.w),
          const Divider(height: 1),
        ],
      ),
    );
  }
}

class _RadioLabel extends StatelessWidget {
  const _RadioLabel({required this.label, this.selected = false, this.onTap});
  final String label;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 20.w,
            height: 20.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: selected
                    ? GiftPoseColors.primaryColor
                    : const Color(0xFF636366),
                width: 2,
              ),
            ),
            alignment: Alignment.center,
            child: selected
                ? Container(
                    width: 10.w,
                    height: 10.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: GiftPoseColors.primaryColor,
                    ),
                  )
                : null,
          ),
          SizedBox(width: 8.w),
          Text(label, style: GiftPoseTextStyle.small()),
        ],
      ),
    );
  }
}
