import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:giftpose/screens/donor_flow/viewmodels/donor_viewmodel.dart';
import 'package:giftpose/screens/donor_flow/widgets/donor_widgets.dart';
import 'package:giftpose/utils/theme/giftpose_colors.dart';
import 'package:giftpose/utils/theme/giftpose_text_style.dart';
import 'package:giftpose/utils/widgets/Giftpose_basescafold.dart';
import 'package:giftpose/utils/widgets/giftpose_button.dart';
import 'package:provider/provider.dart';

class DonorEditCategoryScreen extends StatelessWidget {
  const DonorEditCategoryScreen({super.key});

  static const categories = [
    'Laptop',
    'Home',
    'Fashion',
    'Electronic',
    'Home',
    'Art',
    'Fashion',
    'Home',
  ];
  static const tags = [
    'Luxury',
    'Book',
    'Jewelry',
    'Art',
    'Toys',
    'Books',
    'Luxury',
    'Book',
    'Jewelry',
    'Art',
    'Toys',
    'Books',
  ];

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<DonorViewmodel>();
    return GiftPoseBaseScaffold(
      showAppBar: false,
      includeHorizontalPadding: false,
      includeVerticalPadding: false,
      hasGradient: false,
      builder: (_) => Padding(
        padding: EdgeInsets.fromLTRB(16.w, 34.w, 16.w, 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DonorHeader(title: 'Edit Category'),
            SizedBox(height: 26.w),
            TextField(
              decoration: InputDecoration(
                hintText: 'Search for category',
                prefixIcon: const Icon(Icons.search, color: Color(0xFFB2B2B2)),
                contentPadding: EdgeInsets.symmetric(vertical: 14.w),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6.r),
                  borderSide: BorderSide(color: GiftPoseColors.borderColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6.r),
                  borderSide: BorderSide(color: GiftPoseColors.primaryColor),
                ),
              ),
            ),
            SizedBox(height: 25.w),
            Text(
              'Selected Category',
              style: GiftPoseTextStyle.normal(
                fontSize: 14,
                color: const Color(0xFF344054),
              ),
            ),
            SizedBox(height: 14.w),
            Container(
              height: 40.w,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                color: const Color(0xFFE9FFE9),
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(color: GiftPoseColors.primaryColor),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    vm.category,
                    style: GiftPoseTextStyle.normal(
                      fontSize: 14,
                      color: GiftPoseColors.primaryColor,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  const Icon(Icons.close, size: 17, color: Color(0xFF69B86D)),
                ],
              ),
            ),
            SizedBox(height: 15.w),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 94.w,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 13.w),
                          child: Text(
                            'Categories',
                            style: GiftPoseTextStyle.small(),
                          ),
                        ),
                        ...categories.map(
                          (category) => InkWell(
                            onTap: () => vm.setCategory(category),
                            child: Container(
                              width: double.infinity,
                              height: 38.w,
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(left: 15.w),
                              decoration: category == vm.category
                                  ? BoxDecoration(
                                      border: Border(
                                        left: BorderSide(
                                          color: GiftPoseColors.primaryColor,
                                          width: 2,
                                        ),
                                      ),
                                    )
                                  : null,
                              child: Text(
                                category,
                                style: GiftPoseTextStyle.small(
                                  color: const Color(0xFF667085),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 13.w),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: 54.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Fashionable Item',
                            style: GiftPoseTextStyle.small(
                              color: const Color(0xFF857878),
                            ),
                          ),
                          SizedBox(height: 10.w),
                          Wrap(
                            spacing: 8.w,
                            runSpacing: 12.w,
                            children: tags
                                .map(
                                  (tag) => OutlinedButton(
                                    onPressed: () {},
                                    style: OutlinedButton.styleFrom(
                                      minimumSize: Size(0, 36.w),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 16.w,
                                      ),
                                      side: BorderSide(
                                        color: GiftPoseColors.borderColor,
                                      ),
                                      shape: const StadiumBorder(),
                                    ),
                                    child: Text(
                                      tag,
                                      style: GiftPoseTextStyle.normal(
                                        fontSize: 14,
                                        color: const Color(0xFF344054),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                          SizedBox(height: 12.w),
                          Text(
                            'Clothing Items',
                            style: GiftPoseTextStyle.small(
                              color: const Color(0xFF857878),
                            ),
                          ),
                          SizedBox(height: 10.w),
                          Wrap(
                            spacing: 8.w,
                            runSpacing: 12.w,
                            children: tags
                                .take(9)
                                .map(
                                  (tag) => OutlinedButton(
                                    onPressed: () {},
                                    style: OutlinedButton.styleFrom(
                                      minimumSize: Size(0, 36.w),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 16.w,
                                      ),
                                      side: BorderSide(
                                        color: GiftPoseColors.borderColor,
                                      ),
                                      shape: const StadiumBorder(),
                                    ),
                                    child: Text(
                                      tag,
                                      style: GiftPoseTextStyle.normal(
                                        fontSize: 14,
                                        color: const Color(0xFF344054),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            GiftPoseButton(
              title: 'Submit',
              height: 49,
              scaleHeightByWidth: true,
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
