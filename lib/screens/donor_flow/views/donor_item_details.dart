import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:giftpose/screens/donor_flow/views/donor_post_item.dart';
import 'package:giftpose/screens/donor_flow/widgets/donor_widgets.dart';
import 'package:giftpose/utils/router/app_routes.dart';
import 'package:giftpose/utils/theme/giftpose_colors.dart';
import 'package:giftpose/utils/theme/giftpose_text_style.dart';
import 'package:giftpose/utils/widgets/Giftpose_basescafold.dart';
import 'package:giftpose/utils/widgets/giftpose_button.dart';

class DonorItemDetailsScreen extends StatelessWidget {
  const DonorItemDetailsScreen({super.key});

  static const description =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit purus sit amet purus sit amet Lorem ipsum dolor sit amet, consectetur adipiscing elit purus sit amet purus sit amet';

  @override
  Widget build(BuildContext context) {
    return GiftPoseBaseScaffold(
      showAppBar: false,
      includeHorizontalPadding: false,
      includeVerticalPadding: false,
      hasGradient: false,
      builder: (_) => Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(16.w, 25.w, 16.w, 18.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const DonorHeader(title: 'Item Details'),
                  SizedBox(height: 27.w),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6.r),
                    child: Image.asset(
                      'assets/images/requester/request_item_example.jpg',
                      width: 343.w,
                      height: 277.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 21.w),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Neatly Used Laptop',
                          style: GiftPoseTextStyle.normal(fontSize: 14),
                        ),
                      ),
                      InkWell(
                        onTap: () => Navigator.pushNamed(
                          context,
                          AppRoutes.donorInterestedUsers,
                        ),
                        child: Text(
                          'Interested Users (12)',
                          style: GiftPoseTextStyle.small(
                            color: GiftPoseColors.primaryColor,
                          ).copyWith(decoration: TextDecoration.underline),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.w),
                  const DonorLocationRow(),
                  SizedBox(height: 29.w),
                  Text(
                    description,
                    style: GiftPoseTextStyle.small(
                      color: const Color(0xFF857878),
                    ).copyWith(height: 16 / 12),
                  ),
                  SizedBox(height: 18.w),
                  Text(
                    description,
                    style: GiftPoseTextStyle.small(
                      color: const Color(0xFF857878),
                    ).copyWith(height: 16 / 12),
                  ),
                  SizedBox(height: 27.w),
                  const DonorPickupCard(),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(22.w, 0, 13.w, 13.w),
            child: Column(
              children: [
                GiftPoseButton(
                  title: 'Edit Post',
                  height: 49,
                  scaleHeightByWidth: true,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (_) =>
                          const DonorPostItemScreen(isEditing: true),
                    ),
                  ),
                ),
                SizedBox(height: 14.w),
                GiftPoseButton(
                  title: 'Delete Post',
                  height: 49,
                  scaleHeightByWidth: true,
                  buttonType: GiftPoseButtonType.border,
                  backgroundColor: Colors.transparent,
                  borderColor: GiftPoseColors.borderColor,
                  textColor: Theme.of(context).textTheme.bodyLarge?.color,
                  onTap: () => showDonorDeleteSheet(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> showDonorDeleteSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (sheetContext) => Container(
      height: 330.w,
      padding: EdgeInsets.fromLTRB(16.w, 27.w, 16.w, 30.w),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(18.r)),
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: () => Navigator.pop(sheetContext),
              icon: const Icon(Icons.close, color: Color(0xFF64748B)),
            ),
          ),
          CircleAvatar(
            radius: 40.r,
            backgroundColor: const Color(0xFFFFF2F2),
            child: const Icon(Icons.delete_outline, color: Colors.red),
          ),
          SizedBox(height: 13.w),
          Text('Delete Post', style: GiftPoseTextStyle.normal(fontSize: 14)),
          SizedBox(height: 10.w),
          Text(
            'Are you sure you want to delete this post',
            style: GiftPoseTextStyle.small(color: const Color(0xFF9A9494)),
          ),
          const Spacer(),
          GiftPoseButton(
            title: 'Yes, Delete',
            height: 49,
            scaleHeightByWidth: true,
            onTap: () => Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.donorMyDonations,
              (_) => false,
            ),
          ),
          SizedBox(height: 12.w),
          GiftPoseButton(
            title: 'No, Dont Delete',
            height: 49,
            scaleHeightByWidth: true,
            buttonType: GiftPoseButtonType.border,
            backgroundColor: Colors.transparent,
            borderColor: GiftPoseColors.borderColor,
            textColor: Theme.of(context).textTheme.bodyLarge?.color,
            onTap: () => Navigator.pop(sheetContext),
          ),
        ],
      ),
    ),
  );
}
